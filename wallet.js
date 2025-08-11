import { ethers, verifyMessage } from 'ethers';

async function createWallet() {
    // 1. Rastgele wallet oluştur
    const wallet = ethers.Wallet.createRandom();
    
    console.log('Address:', wallet.address);
    console.log('Private Key:', wallet.privateKey);
    console.log('Mnemonic:', wallet.mnemonic.phrase);
    
    // 2. Private key'den wallet
    const privateKey = wallet.privateKey;
    const walletFromKey = new ethers.Wallet(privateKey);
    console.log('Wallet from private key:', walletFromKey.address);
    
    // 3. Mnemonic'ten wallet (v6'da fromPhrase)
    const mnemonic = wallet.mnemonic.phrase;
    const walletFromMnemonic = ethers.Wallet.fromPhrase(mnemonic);
    console.log('Wallet from mnemonic phrase:', walletFromMnemonic.address);
    
    // 4. İmza atma
    const message = "Hello Ethereum";
    const signature = await wallet.signMessage(message);
    console.log('Signature:', signature);
    
    // 5. İmzayı doğrulama - v6 syntax
    const recoveredAddress = verifyMessage(message, signature);
    console.log('Recovered:', recoveredAddress);
    console.log('Match:', recoveredAddress === wallet.address);
}

createWallet();