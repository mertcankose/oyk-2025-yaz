// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}

contract NumberGuessingGame {
    struct Player {
        address playerAddress;
        string name;
        uint256 secretNumber;
        bool isPlaying;
    }

    // State variables
    IERC20 public gameToken;
    uint256 private nonce;

    // Mappings
    mapping(address => Player) public players;

    // Events
    event GameStarted(address player);
    event GuessResult(address player, uint256 guess, string result);
    event GameWon(address player, uint256 reward);
    event HintGiven(address player, string hint);

    constructor(address _token) {
        gameToken = IERC20(_token);
    }

    // Yeni oyun başlat
    function startGame(string memory _name) external {
        require(!players[msg.sender].isPlaying, "Zaten oynuyorsun");
        require(bytes(_name).length > 0, "İsim boş olamaz");

        // Random sayı üret (1-100)
        nonce++;
        uint256 randomNum = (uint256(
            keccak256(
                abi.encodePacked(
                    block.timestamp,
                    block.prevrandao,
                    msg.sender,
                    nonce
                )
            )
        ) % 100) + 1;

        players[msg.sender] = Player({
            playerAddress: msg.sender,
            name: _name,
            secretNumber: randomNum,
            isPlaying: true
        });

        emit GameStarted(msg.sender);
    }

    // Tahmin yap
    function makeGuess(uint256 _guess) external {
        require(players[msg.sender].isPlaying, "Önce oyun başlat");
        require(_guess >= 1 && _guess <= 100, "1-100 arası sayı gir");

        // 50 token harca
        require(
            gameToken.transferFrom(msg.sender, address(this), 50),
            "50 token gerekli"
        );

        uint256 secret = players[msg.sender].secretNumber;

        if (_guess == secret) {
            // Kazandı! 100 token ödül
            players[msg.sender].isPlaying = false;

            require(
                gameToken.transfer(msg.sender, 500),
                "Ödül transfer başarısız"
            );

            emit GuessResult(msg.sender, _guess, "KAZANDIN!");
            emit GameWon(msg.sender, 500);
        } else if (_guess < secret) {
            emit GuessResult(msg.sender, _guess, "Daha BUYUK");
        } else {
            emit GuessResult(msg.sender, _guess, "Daha KUCUK");
        }
    }

    // İpucu al
    function getHint() external {
        require(players[msg.sender].isPlaying, "Önce oyun başlat");

        // 25 token harca
        require(
            gameToken.transferFrom(msg.sender, address(this), 25),
            "25 token gerekli"
        );

        uint256 secret = players[msg.sender].secretNumber;
        string memory hint;

        if (secret <= 25) {
            hint = "1-25 arası";
        } else if (secret <= 50) {
            hint = "26-50 arası";
        } else if (secret <= 75) {
            hint = "51-75 arası";
        } else {
            hint = "76-100 arası";
        }

        emit HintGiven(msg.sender, hint);
    }

    // Oyunu bırak
    function quitGame() external {
        require(players[msg.sender].isPlaying, "Oyun oynmuyorsun");
        players[msg.sender].isPlaying = false;
    }

    // Oyuncu bilgisi
    function getPlayerInfo(
        address _player
    )
        external
        view
        returns (address playerAddress, string memory name, bool isPlaying)
    {
        Player memory player = players[_player];
        return (player.playerAddress, player.name, player.isPlaying);
    }
}
