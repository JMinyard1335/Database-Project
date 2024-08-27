const express = require('express');
const path = require('path');
const bodyparser = require('body-parser');
const { sequelize, User, Task } = require('./db/models');

const app = express();
app.use(bodyparser.json());
app.use(bodyparser.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, '..', 'public')));

// Creates a new user.
app.post('/create/user', async (req, res) => {

    const { firstname, lastname, age } = req.body
    console.log('Received data:', req.body);

    try {

        const user = await User.create({ firstname, lastname, age });
        console.log('User created:', user);
        return res.json(user);

    } catch (error) {

        console.error('ERROR OCCURED:', error);
        return res.status(500).json(error);

    }
});

// Request all users from the server
app.get('/find', async (req, res) => {
    try {

        const users = await User.findAll();
        return res.json(users);

    } catch (error) {

        console.error('ERROR OCCURED', error);
        return res.status(500).json(error);

    }
});

// Request a user by there first name.
// Better if it was an idnumber.
app.get('/find/name', async (req, res) => {
    const firstname = req.query.firstname;
    try {

        const users = await User.findAll({
            where: { firstname: firstname },

        });
        console.log('Users Found: ', users);
        return res.json(users);

    } catch (error) {

        console.error('ERROR OCCURED', error);
        return res.status(500).json(error);

    }
});


app.delete('/users/:id', async (req, res) => {
    const userId = req.params.id;

    try {

        const user = await User.destroy({
            where: { id: userId }
        })

        if (user) {

            console.log('User deleted: ', user);
            return res.status(200).json({ message: 'User deleted sucessfully' });

        } else {

            console.log('User not found', userId);
            return res.status(404).json({ message: 'User not found' })

        }

    } catch (error) {

        console.error('ERROR OCCURED', error);
        return res.status(500).json(error);

    }
});

app.listen({ port: 5000 }, async () => {
    console.log('Server up on localhost:5000');

    try {

        await sequelize.authenticate();
        console.log('Database Connected');

    } catch (error) {

        console.error('DATABASE UNABLE TO CONNECT: ', error);

    }
});