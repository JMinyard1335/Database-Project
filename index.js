const { sequelize, User } = require('./models');

/**
 * This function makes sure the databases are synced
 * A better method for synch then force needs to be implamented.
 */
async function databaseSync() {
    // In the long run this is not an acceptable way to sync the db.
    console.log('Synching Database...');
    await sequelize.sync({ force: true });
    console.log('Database Synched');
}

databaseSync();
const user = User.build({ firstName: 'Jachin', lastName: 'Minyard', email: 'jachinminyard@gmail.com' });

