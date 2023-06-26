document.addEventListener('DOMContentLoaded', function() {
  const storyContainer = document.getElementById('storyContainer');

    // Function to generate a story dynamically
    function generateStory() {
      // TODO: Add your story generation logic here
      var story = "This is a dynamically generated story.";
      
      // Create a new story container
      var storyDiv = document.createElement("div");
      storyDiv.className = "col-12 story";
      storyDiv.textContent = story;

      // Append the story container to the storyContainer div
      document.getElementById("storyContainer").appendChild(storyDiv);
    }

    // Event listener for the generateButton
    document.getElementById("generateButton").addEventListener("click", generateStory);
  // Fetch story data from your API
  fetch('https://nanocheeze.com/stories')
    .then(response => response.json())
    .then(data => {
      const stories = data;

      stories.forEach(story => {
        const storyCard = createStoryCard(story);
        storyContainer.appendChild(storyCard);
      });
    })
    .catch(error => console.error('Error fetching stories:', error));
});

function createStoryCard(story) {
  const card = document.createElement('div');
  card.classList.add('col-sm-6', 'col-md-4', 'col-lg-3', 'mb-4');

  const cardContent = `
    <div class="card shadow">
      <img src="${story.image}" class="card-img-top" alt="Story Image">
      <div class="card-body">
        <h5 class="card-title">${story.title}</h5>
        <p class="card-text">${story.content.substr(0, 100)}...</p>
        <a href="story.html?id=${story.id}" class="btn btn-primary stretched-link">Read More</a>
        <button class="btn btn-success mt-2 purchase-btn" data-id="${story.id}">Purchase</button>
      </div>
    </div>
  `;

  card.innerHTML = cardContent;

  return card;
}

