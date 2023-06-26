document.addEventListener('DOMContentLoaded', function() {
  const storyDetails = document.getElementById('storyDetails');

  const queryParams = new URLSearchParams(window.location.search);
  const storyId = queryParams.get('id');

  // Fetch story data for the specified ID from your API
  fetch(`https://nanocheeze.com/stories/id/${storyId}`)
    .then(response => response.json())
    .then(story => {
      const storyContent = `
        <h2>${story.title}</h2>
        <p>${story.content}</p>
      `;

      storyDetails.innerHTML = storyContent;
    })
    .catch(error => console.error('Error fetching story:', error));
});
