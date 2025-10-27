// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title Ledgerly
 * @dev A decentralized ledger to record and retrieve transactions.
 */
contract Project {
    struct Transaction {
        address sender;
        address receiver;
        uint256 amount;
        string message;
        uint256 timestamp;
    }

    Transaction[] private ledger;

    event TransactionRecorded(
        address indexed sender,
        address indexed receiver,
        uint256 amount,
        string message,
        uint256 timestamp
    );

    /// @notice Record a new transaction on the blockchain
    function recordTransaction(address receiver, uint256 amount, string memory message) public {
        require(receiver != address(0), "Invalid receiver address");
        require(amount > 0, "Amount must be greater than zero");

        ledger.push(Transaction(msg.sender, receiver, amount, message, block.timestamp));
        emit TransactionRecorded(msg.sender, receiver, amount, message, block.timestamp);
    }

    /// @notice Get total number of transactions
    function getTransactionCount() public view returns (uint256) {
        return ledger.length;
    }

    /// @notice Retrieve all transactions
    function getAllTransactions() public view returns (Transaction[] memory) {
        return ledger;
    }
}
