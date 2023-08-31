import ballerina/http;

http:Client permissionClient = check new("http://localhost:8443/v1", auth = {token: "foobar"});

service /permission on new http:Listener(9191) {
    resource function post checkpermission(PermissionCheck requestData) returns json|error {
        return permissionClient->post("/permissions/check", requestData);
    }
}

type Consistency record {
    boolean minimizeLatency;
};

type Resource record {
    string object_type;
    string object_id;
};

type Object record {
    string object_type;
    string object_id;
};

type Subject record {
    Object 'object;
};

type PermissionCheck record {
    Consistency consistency?;
    Resource 'resource;
    string permission;
    Subject subject;
};

