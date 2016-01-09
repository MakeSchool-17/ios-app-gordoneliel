var Connection = Parse.Object.extend("Connection");
var ConnectionRequest = Parse.Object.extend("ConnectionRequest");
var Appointment = Parse.Object.extend("Appointment");

Parse.Cloud.define("AddToConnections", function(request, response) {
    Parse.Cloud.useMasterKey();

    var connectionRequestId = request.params.connectionRequest;
    var query = new Parse.Query(ConnectionRequest);

    //get the ConnectionRequest object
    query.get(connectionRequestId, {

        success: function(connectionRequest) {

            //get the user the request was from
            var fromUser = connectionRequest.get("fromUser");
            //get the user the request is to
            var toUser = connectionRequest.get("toUser");

        //     var connectionObject = new Connection();
        //     connectionObject.set("fromUser", fromUser);
        //     connectionObject.set("toUser", toUser);
        //
        //     // Save the connection relation
        //     connectionObject.save(null, {
        //         success: function(connectionObject) {
        //
        //             // Update the connection request to reflect connection status
        //             connectionRequest.set("accepted", true);
        //             connectionRequest.save(null, {
        //
        //                 success: function() {
        //
        //                     response.success("Saved connection and updated Connection Request");
        //                 },
        //
        //                 error: function(error) {
        //
        //                     response.error(error);
        //                 }
        //
        //             });
        //         }
        //     },
        //       error: function(connectionObject, error) {
        //         // Execute any logic that should take place if the save fails.
        //         // error is a Parse.Error with an error code and message.
        //         console.log(error.message);
        //       }
        // });
//     });
// });
            // console.log(fromUser)
            // console.log(toUser);
            // console.log(connectionObject);

            var relation = fromUser.relation("connections");
            //add the user the request was to (the accepting user) to the fromUsers friends
            relation.add(toUser);

            fromUser.save(null, {

                success: function() {

                    //saved the user, now edit the request status and save it
                    connectionRequest.set("accepted", true);
                    connectionRequest.save(null, {

                        success: function() {

                            response.success("Saved connection and updated Connection Request");
                        },

                        error: function(error) {

                            response.error(error);
                        }

                    });

                },

                error: function(error) {

                 response.error(error);

                }

            });

        },

        error: function(error) {

            response.error(error);

        }

    });
});

Parse.Cloud.afterSave("ConnectionRequest", function(request, response) {

    var userQuery = new Parse.Query(Parse.User);
    userQuery.get(request.object.get("toUser").id).then(
        function (toUser) {
            var fromUserQuery = new Parse.Query(Parse.User);

            fromUserQuery.get(request.object.get("fromUser").id).then(
                function (fromUser) {
                    console.log("To User is: " + toUser.get("name"));
                    console.log("From User is: " + fromUser.get("name"));

                    var pushQuery = new Parse.Query(Parse.Installation);
                    pushQuery.equalTo('user', toUser);

                    Parse.Push.send({
                        where: pushQuery, // Set our Installation query
                        data: {
                          alert: "Recieved a connection request from " + fromUser.get("name")
                        }
                    }).then(
                        function() {
                            console.log("Push successful");
                        },
                        function(error) {
                            console.log("Got an error " + error.code + " : " + error.message);
                            throw "Got an error " + error.code + " : " + error.message;
                    });
                },
                function (error) {
                    console.log("Got an error in push user query " + error.code + " : " + error.message);
                });
        },
        function (error) {
            // body...
        });
});

/* Prevents duplicate booked times */
Parse.Cloud.beforeSave("Appointment", function (request, response) {
    if (!request.object.isNew()) {
        // Let existing object updates go through
        response.success();
    }

    var query = new Parse.Query(Appointment);
    // Add query filters to check for uniqueness

    var fromTime = new Date(request.object.get("fromTime"));
    var toTime = new Date(request.object.get("toTime"));

    query.equalTo("toMentor", request.object.get("toMentor"));

    query.lessThan("fromTime", toTime);
    query.greaterThan("toTime", fromTime);

    query.first().then(function (existingObject) {
        if (existingObject) {
            return Parse.Promise.as(100);
        } else {
            return Parse.Promise.as(200);
        }
    }).then(function (existingObject) {
        if (existingObject == 100) {
            // Existing object, stop initial save
            response.error("This appointment time is already booked.");
        } else {
            // New object, let the save go through
            response.success();
        }
    }, function (error) {
        response.error("Error performing checks or saves.");
    });
});
