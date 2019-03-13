db.auth('root', 'example')

db = db.getSiblingDB('raven-api-livenet')

db.createUser({
  user: 'raven',
  pwd: 'thebirdistheword',
  roles: [
    {
      role: 'readWrite',
      db: 'raven-api-livenet',
    },
  ],
});