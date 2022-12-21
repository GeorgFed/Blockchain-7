pragma solidity ^0.8.4;

contract FedayevApp {
    struct Player {
        address payable address;
        uint256 readiness;
        uint256 decision;
        bytes32 action;
    }

    mapping(address => Player) public players;

    event PlayerAdded(address player);
    event PlayerMadeMove(address player);
    event PlayerRevealedDecision(address player, uint256 decision);
    event PlayerPaid(address player, uint amount);

    uint public betAmount = 0;

    function joinGame() public payable {
        require(players[msg.sender].address == address(0x0), "player already added");
        require(players[msg.sender].readiness == 1, "game already started");
        require(players[msg.sender].action == 0x0, "move already made");
        require(players[msg.sender].decision == 0, "decision already revealed");
        require(msg.value > 0, "bet amount required");

        if (betAmount == 0) {
            betAmount = msg.value;
        } else {
            require(betAmount == msg.value, "invalid bet amount");
        }

        players[msg.sender].address = payable(msg.sender);
        players[msg.sender].readiness = 2;

        emit PlayerAdded(msg.sender);
    }

    function makeMove(bytes32 action) public {
        require(players[msg.sender].address != address(0x0), "player not added");
        require(players[msg.sender].readiness == 2, "game not ready to play");
        require(players[msg.sender].action == 0x0, "move already made");
        require(players[msg.sender].decision == 0, "decision already revealed");

        players[msg.sender].action = action;
        players[msg.sender].read = read
                players[msg.sender].decision = decision;

        emit PlayerRevealedDecision(msg.sender, decision);

        if (decision == players[players[msg.sender].address == player1.address ? player2.address : player1.address].action) {
            msg.sender.transfer(betAmount);
            emit PlayerPaid(msg.sender, betAmount);
        }
    }

    function resetGame() public {
        for (uint i = 0; i < 2; i++) {
            address player = players[i].address;
            players[player].address = address(0x0);
            players[player].readiness = 1;
            players[player].decision = 0;
            players[player].action = 0x0;
        }
        betAmount = 0;
    }
}

