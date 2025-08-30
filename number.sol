// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);
}

contract NumberGuessingGame {
    struct Player {
        address playerAddress;
        string name;
        uint256 secretNumber;
        bool isPlaying;
        uint256 totalRewards; // Toplam kazanılan ödüller
        uint256 lastGuess; // Son tahmin edilen sayı
    }

    // State variables
    IERC20 public gameToken;

    // Mappings
    mapping(address => Player) public players;

    // Events
    event GameStarted(address player);
    event GuessResult(address player, uint256 guess, string result);
    event GameWon(address player, uint256 reward);
    event HintGiven(address player, string hint);
    event RewardWithdrawn(address player, uint256 amount);

    constructor(address _token) {
        gameToken = IERC20(_token);
    }

    // Yeni oyun başlat
    function startGame(string memory _name) external {
        require(!players[msg.sender].isPlaying, "Zaten oynuyorsun");

        // Random sayı üret (1-100)
        uint256 randomNum = (uint256(
            keccak256(
                abi.encodePacked(block.timestamp, block.prevrandao, msg.sender)
            )
        ) % 100) + 1;

        players[msg.sender] = Player({
            playerAddress: msg.sender,
            name: _name,
            secretNumber: randomNum,
            isPlaying: true,
            totalRewards: players[msg.sender].totalRewards, // Önceki ödülleri koru
            lastGuess: 0 // Henüz tahmin yok
        });

        emit GameStarted(msg.sender);
    }

    // Tahmin yap
    function makeGuess(uint256 _guess) external {
        require(players[msg.sender].isPlaying, "once oyun baslat");
        require(_guess >= 1 && _guess <= 100, "1-100 arasi sayi gir");

        // Allowance kontrolü
        uint256 currentAllowance = gameToken.allowance(
            msg.sender,
            address(this)
        );
        require(
            currentAllowance >= 50,
            "Yetersiz allowance! Token contractindan approve yapin"
        );

        // 50 token harca
        require(
            gameToken.transferFrom(msg.sender, address(this), 50),
            "Token transferi basarisiz"
        );

        uint256 secret = players[msg.sender].secretNumber;

        // Son tahmini kaydet
        players[msg.sender].lastGuess = _guess;

        if (_guess == secret) {
            // Kazandı! 500 token ödül
            players[msg.sender].isPlaying = false;
            players[msg.sender].totalRewards += 500;

            emit GuessResult(msg.sender, _guess, "KAZANDIN!");
            emit GameWon(msg.sender, 500);
        } else {
            emit GuessResult(msg.sender, _guess, "Yanlis tahmin");
        }
    }

    // İpucu al
    function getHint() external {
        require(players[msg.sender].isPlaying, "once oyun baslat");
        require(players[msg.sender].lastGuess > 0, "once bir tahmin yap");

        // Allowance kontrolü
        uint256 currentAllowance = gameToken.allowance(
            msg.sender,
            address(this)
        );
        require(
            currentAllowance >= 25,
            "Yetersiz allowance! Token contractindan approve yapin"
        );

        // 25 token harca
        require(
            gameToken.transferFrom(msg.sender, address(this), 25),
            "Token transferi basarisiz"
        );

        uint256 secret = players[msg.sender].secretNumber;
        uint256 lastGuess = players[msg.sender].lastGuess;
        string memory hint;

        if (lastGuess < secret) {
            hint = "YUKARI";
        } else {
            hint = "ASAGI";
        }

        emit HintGiven(msg.sender, hint);
    }

    // Ödül çek
    function withdrawReward() external {
        uint256 reward = players[msg.sender].totalRewards;
        require(reward > 0, "cekilecek odul yok");

        // Ödülü sıfırla (reentrancy koruması)
        players[msg.sender].totalRewards = 0;

        // Token transfer et
        require(
            gameToken.transfer(msg.sender, reward),
            "odul transferi basarisiz"
        );

        emit RewardWithdrawn(msg.sender, reward);
    }

    // Oyuncu bilgisi
    function getPlayerInfo(
        address _player
    )
        external
        view
        returns (
            address playerAddress,
            string memory name,
            bool isPlaying,
            uint256 totalRewards
        )
    {
        Player memory player = players[_player];
        return (
            player.playerAddress,
            player.name,
            player.isPlaying,
            player.totalRewards
        );
    }
}
