pragma solidity 0.5.6;

contract PlantShop {
    struct Plant {
        string name;
        uint256 price;
        address buyer;
    }

    struct Story {
        string title;
        string content;
        address author;
        uint256 price;
        bool isPurchased;
    }

    Plant[16] public plants;
    Story[] public stories;
    mapping(uint256 => address) public storyToOwner;

    event PlantPurchased(uint256 plantId, address buyer);
    event StoryPurchased(uint256 storyId, address buyer);

    function buyPlant(uint256 plantId) public returns (uint256) {
        require(plantId >= 0 && plantId <= 15, "Invalid plant ID");
        plants[plantId].buyer = msg.sender;
        emit PlantPurchased(plantId, msg.sender);
        return plantId;
    }

    function getPlantBuyers() public view returns (address[16] memory) {
        address[16] memory plantBuyers;
        for (uint256 i = 0; i < 16; i++) {
            plantBuyers[i] = plants[i].buyer;
        }
        return plantBuyers;
    }

    function createStory(string memory _title, string memory _content, uint256 _price) public {
        uint256 newStoryId = stories.length;
        stories.push(Story(_title, _content, msg.sender, _price, false));
        storyToOwner[newStoryId] = msg.sender;
    }

    function purchaseStory(uint256 _storyId) public payable {
        require(_storyId < stories.length, "Invalid story ID");
        Story storage story = stories[_storyId];
        require(!story.isPurchased, "Story has already been purchased");
        require(msg.value >= story.price, "Insufficient funds");

        story.isPurchased = true;
        storyToOwner[_storyId] = msg.sender;

        emit StoryPurchased(_storyId, msg.sender);

        if (msg.value > story.price) {
            msg.sender.transfer(msg.value - story.price);
        }
    }

    function getStoryCount() public view returns (uint256) {
        return stories.length;
    }

    function isStoryPurchased(uint256 _storyId) public view returns (bool) {
        require(_storyId < stories.length, "Invalid story ID");
        return stories[_storyId].isPurchased;
    }

    function getStory(uint256 _storyId) public view returns (string memory, string memory, address, uint256, bool) {
        require(_storyId < stories.length, "Invalid story ID");
        Story storage story = stories[_storyId];
        return (story.title, story.content, story.author, story.price, story.isPurchased);
    }
}
