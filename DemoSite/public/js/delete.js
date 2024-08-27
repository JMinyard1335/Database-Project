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