
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
