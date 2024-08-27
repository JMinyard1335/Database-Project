
document.getElementById('listusers').addEventListener('click', async () => {
    try {
        const response = await fetch('/find');
        const users = await response.json();

        const userList = document.getElementById('userlist');
        userList.innerHTML = '';

        users.forEach(user => {
            const li = document.createElement('li');
            li.classList.add("text-white")
            li.textContent = `${user.firstname} ${user.lastname}, age: ${user.age}, Id: ${user.id}`;
            userList.appendChild(li);
        });
    } catch (error) {
        alert('Failed to load users.');
        console.error('ERROR:', error);
    }
});

document.getElementById('usersearch').addEventListener('submit', async (e) => {
    e.preventDefault();

    try {

        // Pull the first name out of the html using the id of the input tag
        const firstname = document.getElementById('nameSearch').value;
        const response = await fetch(`/find/name?firstname=${encodeURIComponent(firstname)}`);
        console.log('The response is: ', response);

        // Throw an error if the response is unacceptable
        if (!response.ok) {
            throw new Error("Server Response Failed");
        }

        // If the response is safe then collect all the users matching the query.
        const users = await response.json();
        /**
         * Display the results in a list
         * to do this we need to find the list tag in the html then create a new item for each user.
         */
        const list = document.getElementById('foundusers');
        list.innerHTML = ' ';

        users.forEach(user => {
            const li = document.createElement('li');

            li.textContent = `${user.firstname} ${user.lastname}, age: ${user.age}, Id: ${user.id}`;
            list.appendChild(li);
        });

    } catch (error) {

        alert('Failed to load users.');
        console.error('ERROR:', error);

    }
});


document.getElementById('userdelete').addEventListener('submit', async (e) => {
    e.preventDefault();

    try {
        // Get the user ID from the input field
        const userId = document.getElementById('idDelete').value;

        // Send a DELETE request to the server to delete the user
        const response = await fetch(`/users/${encodeURIComponent(userId)}`, {
            method: 'DELETE',
        });

        // Handle the server response
        const result = await response.json();
        const deleteResult = document.getElementById('deleteResult');

        if (response.ok) {
            deleteResult.textContent = result.message;
            deleteResult.style.color = 'green';
        } else {
            deleteResult.textContent = result.message || 'Failed to delete user.';
            deleteResult.style.color = 'red';
        }

    } catch (error) {
        console.error('ERROR:', error);
        document.getElementById('deleteResult').textContent = 'An error occurred while trying to delete the user.';
        document.getElementById('deleteResult').style.color = 'red';
    }
});


document.getElementById('userform').addEventListener('submit', async (e) => {
    e.preventDefault();

    const firstname = document.getElementById('firstname').value;
    const lastname = document.getElementById('lastname').value;
    const age = document.getElementById('age').value;

    try {
        const response = await fetch('/create/user', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ firstname, lastname, age })
        });

        const user = await response.json();
        console.log('Response from server: ', user);
        alert(`User ${user.firstname} ${user.lastname} created successfully!`);

    } catch (error) {

        alert(`Failed To Create User.`);
        console.error('ERROR OCCURED:', error);

    }
});
