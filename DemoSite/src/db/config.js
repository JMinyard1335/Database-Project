/**
 * This file is the database config for accessing the db.
 * You can set different database for each stage if needed.
 */
const path = require('path');
const storage = path.join(__dirname, 'database.db');

module.exports = {
  development: {
    dialect: 'sqlite',
    storage
  },
  test: {
    dialect: 'sqlite',
    storage: ':memory'
  },
  production: {
    use_env_variable: 'DB_CONNECTION_STRING',
    dialect: "postgres",
    logging: false
  }
};