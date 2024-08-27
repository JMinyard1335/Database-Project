
document.getElementById('listusers').addEventListener('click', async () => {
    try {
        const response = await fetch('/find');
        const users = await response.json();

        const userList = document.getElementById('userlist');
        userList.innerHTML = '';

        users.forEach(user => {
            const li = document.createElement('li');
            li.textContent = `${user.firstname} ${user.lastname}, age: ${user.age}, Id: ${user.id}`;
            userList.appendChild(li);
        });
    } catch (error) {
        alert('Failed to load users.');
        console.error('ERROR:', error);
    }
});


/**
 * Make A function to search for a speific user.
 * We need to query the backend and pass it a users firstname.
 * Then we need to display all the characters with this name.
 */
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
