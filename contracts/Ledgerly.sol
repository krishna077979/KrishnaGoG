// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Ledgerly {
    struct Entry {
        address creator;
        uint256 timestamp;
        string data; // Could be a hash, description, or IPFS link
    }

    // Mapping of ledger entry ID to Entry
    mapping(uint256 => Entry) private entries;
    uint256 private nextEntryId = 1;

    // Event emitted when a new ledger entry is added
    event EntryAdded(uint256 indexed entryId, address indexed creator, uint256 timestamp, string data);

    // Function to add a new ledger entry
    function addEntry(string memory data) external {
        require(bytes(data).length > 0, "Data cannot be empty");

        entries[nextEntryId] = Entry({
            creator: msg.sender,
            timestamp: block.timestamp,
            data: data
        });

        emit EntryAdded(nextEntryId, msg.sender, block.timestamp, data);
        nextEntryId++;
    }

    // View ledger entry by ID
    function viewEntry(uint256 entryId) external view returns (address creator, uint256 timestamp, string memory data) {
        Entry memory e = entries[entryId];
        require(e.timestamp != 0, "Entry does not exist");
        return (e.creator, e.timestamp, e.data);
    }

    // Total ledger entries
    function totalEntries() external view returns (uint256) {
        return nextEntryId - 1;
    }
}
