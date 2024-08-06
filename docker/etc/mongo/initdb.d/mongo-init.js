print('Start #################################################################');

db = db.getSiblingDB('new-project');
db.createUser(
    {
        user: "project-user",
        pwd: "project-password",
        roles: [
            {
                role: "readWrite",
                db: "new-project"
            }
        ]
    }
);

db.createCollection('users');

print('END #################################################################');
