// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract StudentLogin {
    struct Student {
        string username;
        string password;
        bool isLoggedIn;
    }
    
    mapping(address => Student) public students;
    mapping(string => bool) private usernameExists;

    event StudentRegistered(address indexed studentAddress, string username);
    event StudentLoggedIn(address indexed studentAddress, string username);
    
    function register(string memory _username, string memory _password) public {
        require(!usernameExists[_username], "Username already exists");
        
        students[msg.sender] = Student(_username, _password, false);
        usernameExists[_username] = true;
        
        emit StudentRegistered(msg.sender, _username);
    }
    
    function login(string memory _username, string memory _password) public {
        require(usernameExists[_username], "Username does not exist");
        require(keccak256(bytes(students[msg.sender].password)) == keccak256(bytes(_password)), "Incorrect password");
        
        students[msg.sender].isLoggedIn = true;
        
        emit StudentLoggedIn(msg.sender, _username);
    }
    
    function isLoggedIn() public view returns (bool) {
        return students[msg.sender].isLoggedIn;
    }
}
