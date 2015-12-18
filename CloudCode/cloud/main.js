var Appointment = Parse.Object.extend("Appointment");

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
