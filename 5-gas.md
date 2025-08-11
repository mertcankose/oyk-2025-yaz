# Ethereum'da Gas Nedir?

## Basit Tanım
Gas, Ethereum ağında işlem yapmak için ödediğiniz ücrettir. Tıpkı arabanızın benzin ile çalışması gibi, Ethereum'daki her işlem de gas ile çalışır. Her işlem belirli miktarda hesaplama gücü gerektirir ve bu güç "gas" ile ölçülür.

## Neden Gas Gerekli?

### 1. Spam Koruması
Ethereum ağını korumak için her işlemin bir maliyeti olmalıdır. Aksi takdirde kötü niyetli kişiler ağı sonsuz işlemlerle doldurabilir.

### 2. Hesaplama Kaynaklarının Ödüllendirilmesi
Ethereum Virtual Machine (EVM) üzerinde çalışan her işlem, dünya çapındaki bilgisayarların işlem gücünü kullanır. Gas, bu kaynakları sağlayan kişilere (validatörlere) ödeme yapar.

### 3. Ağ Dengesi
Gas fiyatları arz-talep dengesine göre belirlenir. Ağ yoğun olduğunda gas fiyatları artar, böylece acil olmayan işlemler ertelenir.

## Gas Bileşenleri

### Gas Limit (Gas Limiti)
Gas limiti, bir işlem için harcamaya razı olduğunuz maksimum gas miktarıdır.

**Kim Belirliyor?**
- **Basit transferlerde:** Cüzdan otomatik belirler (ETH transferi her zaman 21,000)
- **Akıllı kontrat işlemlerinde:** Cüzdan tahmin eder (eth_estimateGas fonksiyonu ile)
- **Manuel ayarlama:** Kullanıcı isterse değiştirebilir

**Nasıl Hesaplanıyor?**
Her EVM işleminin sabit bir gas maliyeti vardır:
- ADD (toplama): 3 gas
- MUL (çarpma): 5 gas
- SSTORE (veri kaydetme): 20,000 gas
- ETH transfer: 21,000 gas (sabit)

**Örnekler:**
- Basit ETH transferi: 21,000 gas (sabit)
- ERC-20 token transferi: ~65,000 gas
- NFT mint işlemi: 100,000-200,000 gas
- DeFi swap işlemi: 150,000-300,000 gas

**Önemli:** Gas limitini çok düşük ayarlarsanız işleminiz yarıda kesilir ve başarısız olur. Ancak harcanan gas geri alınmaz!

### Gas Price (Gas Fiyatı)
Her bir gas birimi için ödediğiniz ETH miktarıdır. Gwei cinsinden ölçülür.

**Birim Dönüşümleri:**
- 1 ETH = 1,000,000,000 Gwei (1 milyar)
- 1 Gwei = 0.000000001 ETH

**Fiyat Seviyeleri:**
- Düşük (Slow): 10-20 Gwei - İşlem 5-30 dakika sürebilir
- Orta (Standard): 20-50 Gwei - İşlem 1-5 dakika sürer
- Yüksek (Fast): 50-100 Gwei - İşlem 15-60 saniye sürer
- Çok Yüksek (Instant): 100+ Gwei - Hemen işleme alınır

### Base Fee (Taban Ücret)
EIP-1559 güncellemesi (Ağustos 2021) ile gelen dinamik ücrettir.

**Neden Base Fee Getirildi?**
1. **Tahmin edilebilir ücretler:** Eski sistemde gas fiyatları çok değişkendi
2. **Otomatik fiyatlama:** Kullanıcılar artık doğru fiyatı tahmin etmek zorunda değil
3. **ETH yakma:** Base fee yakılarak ETH arzı azaltılıyor (deflationary)
4. **MEV azaltma:** Madencilerin manipülasyonunu zorlaştırıyor

**Nasıl Çalışır?**
- Blok %50'den fazla doluysa → Base fee %12.5 artar
- Blok %50'den az doluysa → Base fee %12.5 azalır
- Hedef: Her blokun %50 dolu olması

### Priority Fee (Öncelik Ücreti / Tip)
Validatörlere doğrudan giden bahşiş miktarıdır. Yüksek bahşiş = daha hızlı işlem.

**Eski Sistem vs Yeni Sistem:**
- **Eski:** Tüm gas ücreti madenciye gidiyordu
- **Yeni:** Base fee yakılıyor + Priority fee validatöre gidiyor

## Toplam Maliyet Hesaplama

### Eski Sistem (Legacy):
```
İşlem Ücreti = Gas Limit × Gas Price
```

### Yeni Sistem (EIP-1559):
```
İşlem Ücreti = Gas Limit × (Base Fee + Priority Fee)
```

## Gerçek Örnek Senaryolar

### Senaryo 1: Basit ETH Transferi
```
Gas Limit: 21,000
Base Fee: 30 Gwei
Priority Fee: 2 Gwei
Toplam Gas Price: 32 Gwei

Maliyet = 21,000 × 32 = 672,000 Gwei = 0.000672 ETH

ETH fiyatı $2000 ise: 0.000672 × $2000 = $1.34
```

### Senaryo 2: UniSwap Token Takası
```
Gas Limit: 200,000
Base Fee: 50 Gwei
Priority Fee: 5 Gwei
Toplam Gas Price: 55 Gwei

Maliyet = 200,000 × 55 = 11,000,000 Gwei = 0.011 ETH

ETH fiyatı $2000 ise: 0.011 × $2000 = $22
```

## Gas Tasarruf Yöntemleri

### 1. Zamanlama
- Hafta sonları genelde daha ucuz
- ABD uyku saatleri (UTC 05:00-10:00) daha sakin
- Etherscan Gas Tracker'ı kontrol edin

### 2. İşlem Gruplandırma
Birden fazla işlemi tek seferde yapın. Örneğin, 5 ayrı token transferi yerine multi-send kullanın.

### 3. Layer 2 Çözümleri
- Arbitrum: %90'a kadar ucuz
- Optimism: %80'e kadar ucuz
- Polygon: %95'e kadar ucuz

### 4. Gas Token Kullanımı
CHI veya GST2 gibi gas tokenları yüksek gas dönemlerinde tasarruf sağlayabilir.

## Ağ Tıkanıklığı ve Gas Artışı

### Neden Ağ Tıkanır?
Ethereum'u bir otoyol gibi düşünün. Her blok (12-13 saniyede bir üretilir) belirli sayıda işlem alabilir.

**Blok Kapasitesi:**
- Her blok maksimum 30 milyon gas limitine sahip
- Basit transfer 21,000 gas = Bir blokta ~1,400 transfer sığar
- Karmaşık DeFi işlemi 300,000 gas = Bir blokta sadece ~100 işlem sığar

### Tıkanıklık Nedenleri

**1. NFT Mint Olayları**
Popüler bir NFT koleksiyonu satışa çıktığında binlerce kişi aynı anda işlem gönderir.
- Normal gas: 50 Gwei
- NFT mint sırasında: 500-2000 Gwei

**2. DeFi Arbitraj Botları**
Botlar kar fırsatlarını yakalamak için yüksek gas ödemeye razıdır.
- Bot A: 100 Gwei öder
- Bot B: 200 Gwei öder (önce girmek için)
- Bot C: 300 Gwei öder... (gas savaşı başlar)

**3. Piyasa Çöküşleri**
Kripto fiyatları düştüğünde herkes aynı anda:
- Pozisyonlarını kapatmaya çalışır
- Stablecoin'e geçmeye çalışır
- Borçlarını ödemeye çalışır

**4. Airdrop ve Token Satışları**
Ücretsiz token dağıtımlarında herkes ilk olmak ister.

### Gas Fiyatı Nasıl Belirleniyor?

**Açık Artırma Sistemi:**
1. Herkes gas fiyat teklifi verir
2. En yüksek teklifler bloğa girer
3. Düşük teklifler bekler veya iptal olur

**Örnek Senaryo:**
```
Blok kapasitesi: 100 işlem
Bekleyen işlemler: 500 adet

İşlem teklifleri:
- 50 işlem → 200 Gwei ödemeye razı
- 100 işlem → 150 Gwei ödemeye razı  
- 200 işlem → 100 Gwei ödemeye razı
- 150 işlem → 50 Gwei ödemeye razı

Sonuç: Sadece 200 ve 150 Gwei ödeyenler girer
Minimum gas fiyatı: 150 Gwei olur
```

## Sık Karşılaşılan Hatalar

### "Out of Gas" Hatası
**Sebep:** Gas limiti çok düşük ayarlanmış
**Çözüm:** Gas limitini artırın (genelde %20-30 fazla ayarlayın)

### "Transaction Underpriced" Hatası
**Sebep:** Gas price çok düşük
**Çözüm:** Gas price'ı artırın veya ağın sakinleşmesini bekleyin

### Stuck Transaction (Takılı İşlem)
**Sebep:** Düşük gas price ile gönderilmiş işlem
**Çözüm:** 
1. Aynı nonce ile daha yüksek gas price'lı işlem gönderin
2. "Speed up" özelliğini kullanın
3. İşlemi iptal edin (cancel transaction)

## Gelişmiş Konseptler

### Gas Refund (Gas İadesi)
Akıllı kontratlarda depolama alanını temizlediğinizde (SSTORE'dan SLOAD'a) 15,000 gas iade alırsınız.

### Gas Optimization
Akıllı kontrat geliştiricileri için:
- uint256 yerine uint8 kullanmak daha pahalı
- Storage yerine memory kullanın
- Loop'ları minimize edin
- Batch işlemleri tercih edin

### MEV ve Gas Wars
Arbitraj botları ve NFT mint'lerde yüksek gas fiyatları ile öncelik savaşları yaşanır. Bu durumlarda gas fiyatları 1000+ Gwei'ye çıkabilir.

## Etherscan Gas Tracker Açıklaması

### Low, Average, High Kategorileri Ne Anlama Gelir?

**Low (Düşük - Yavaş):**
- **Ne için:** Acil olmayan işlemler, zamanınız varsa
- **Bekleme süresi:** 3-30 dakika (ağ yoğunluğuna göre)
- **Kim kullanmalı:** NFT koleksiyonu görüntüleme, token bakiyesi kontrolü gibi acil olmayan işlemler

**Average (Ortalama - Standart):**
- **Ne için:** Normal işlemler
- **Bekleme süresi:** 30 saniye - 3 dakika
- **Kim kullanmalı:** Çoğu kullanıcı için ideal, token transferleri, swap işlemleri

**High (Yüksek - Hızlı):**
- **Ne için:** Acil işlemler
- **Bekleme süresi:** 15-30 saniye
- **Kim kullanmalı:** DEX arbitrajı, NFT mint, likidasyondan kaçınma gibi zamana duyarlı işlemler

### Nasıl Hesaplanıyor?

**1. Veri Toplama:**
Etherscan son 200 bloktan (yaklaşık 40 dakika) veri toplar:
- Her bloktaki minimum gas fiyatı
- Ortalama gas fiyatı
- İşlem yoğunluğu

**2. Hesaplama Metodolojisi:**
```
Low = Son 200 blokta işlem yapan en düşük %25'lik dilim
Average = Son 200 blokta işlem yapan orta %50'lik dilim  
High = Son 200 blokta işlem yapan en yüksek %90'lık dilim
```

**3. Gerçek Örnek:**
```
Son 200 blokta 10,000 işlem var:
- 2,500 işlem: 20-30 Gwei ödemiş → Low = 25 Gwei
- 5,000 işlem: 30-50 Gwei ödemiş → Average = 40 Gwei
- 2,500 işlem: 50-100 Gwei ödemiş → High = 70 Gwei
```

### Priority Fee Tahmini

Etherscan ayrıca Priority Fee (bahşiş) de gösterir:
- **Low Priority:** 1-2 Gwei
- **Market Priority:** 2-3 Gwei  
- **Aggressive Priority:** 3-5 Gwei

**Toplam Ödeme = Base Fee + Priority Fee**

### Tracker'ı Okuma Örneği

```
Etherscan Gas Tracker gösteriyor:
Base Fee: 30 Gwei
Low: 31 Gwei (1 Gwei priority)
Average: 32 Gwei (2 Gwei priority)
High: 35 Gwei (5 Gwei priority)

Anlamı:
- Low seçerseniz: 31 Gwei ödersiniz, 3-30 dk beklersiniz
- Average seçerseniz: 32 Gwei ödersiniz, 1-3 dk beklersiniz
- High seçerseniz: 35 Gwei ödersiniz, 15-30 sn beklersiniz
```

### Gas Tracker'daki Diğer Bilgiler

**Gas Price by Time of Day:**
- Günün hangi saatlerinde gas ucuz/pahalı
- Genelde UTC 14:00-18:00 en yoğun (ABD uyanık)
- UTC 02:00-06:00 en sakin (Asya gece, ABD uyuyor)

**Gas Guzzlers:**
- En çok gas harcayan kontratlar listesi
- UniSwap, OpenSea genelde ilk sıralarda
- Bu kontratlar yoğunsa gas artar

## Cüzdanlar Gas Ücretini Nasıl Optimize Ediyor?

### 1. Gas Tahmin API'leri

**eth_estimateGas Fonksiyonu:**
```javascript
// Cüzdan bu çağrıyı yapar:
const gasEstimate = await web3.eth.estimateGas({
  from: '0xKullaniciAdresi',
  to: '0xAliciAdresi',
  data: 'işlem verisi'
});

// Sonuç: 65000 gas (örnek)
// Cüzdan %10-20 güvenlik payı ekler: 71500 gas
```

### 2. Mempool (Bekleyen İşlemler Havuzu) Analizi

**Cüzdanlar Nelere Bakar:**
- Son 100 bloktaki minimum gas fiyatları
- Şu an mempool'da bekleyen işlem sayısı
- Bekleyen işlemlerin gas fiyat dağılımı

**Örnek Algoritma:**
```
1. Mempool'da 5000 bekleyen işlem var
2. Gas fiyat dağılımı:
   - 1000 işlem: 100+ Gwei
   - 2000 işlem: 50-100 Gwei  
   - 2000 işlem: 20-50 Gwei

3. Cüzdan hesaplar:
   - Hemen girmek için: 51 Gwei öner
   - Normal için: 35 Gwei öner
   - Yavaş için: 22 Gwei öner
```

### 3. EIP-1559 Akıllı Tahmin

**Base Fee Tahmini:**
```
Mevcut Base Fee: 30 Gwei
Son 5 blok: %90, %85, %95, %80, %88 dolu

Tahmin: Bloklar dolu → Base fee artacak
Sonraki base fee: ~34 Gwei olur

Cüzdan önerisi: 35 Gwei (güvenli taraf)
```

**Priority Fee Hesaplama:**
```
Son 10 blokta kabul edilen priority fee'ler:
Minimum: 1 Gwei (yavaş işlemler)
Ortalama: 2 Gwei (normal işlemler)
Maksimum: 5 Gwei (hızlı işlemler)

Cüzdan kullanıcıya 3 seçenek sunar
```

### 4. Gerçek Dünya Örnekleri

**MetaMask:**
- Infura'nın gas API'sini kullanır
- Son 20 bloku analiz eder
- 3 hız seçeneği sunar (Low, Market, Aggressive)

**Rainbow Wallet:**
- Flashbots RPC kullanır
- MEV koruması sağlar
- Otomatik olarak en optimal gas'ı seçer

**Argent Wallet:**
- Relayer sistemi kullanır
- Kullanıcı gas ödemez (meta-transaction)
- Argent gas maliyetini üstlenir

### 5. Gelişmiş Optimizasyon Teknikleri

**Batch Transaction (Toplu İşlem):**
```solidity
// Kötü: 3 ayrı işlem = 3x gas ücreti
transfer(adres1, 100);  // 65,000 gas
transfer(adres2, 200);  // 65,000 gas
transfer(adres3, 300);  // 65,000 gas
// Toplam: 195,000 gas

// İyi: 1 multicall işlemi
multiTransfer([adres1, adres2, adres3], [100, 200, 300]);
// Toplam: 85,000 gas (yaklaşık %55 tasarruf)
```

**Gas Token Stratejisi:**
```
1. Gas ucuzken CHI token satın al (20 Gwei)
2. Gas pahalıyken CHI yak (200 Gwei)
3. Yakılan CHI gas refund sağlar
4. Efektif gas: 80 Gwei (100 Gwei tasarruf)
```

**Flashloan Optimizasyonu:**
```
Normal yol:
1. USDC → ETH swap (150k gas)
2. ETH → DAI swap (150k gas)
Toplam: 300k gas

Flashloan yolu:
1. Flashloan al + tüm swap'lar + geri öde
Toplam: 180k gas (%40 tasarruf)
```

### 6. Cüzdan Gas Algoritması Örneği

```javascript
function calculateOptimalGas() {
  // 1. Base fee'yi al
  const baseFee = await getBaseFee();
  
  // 2. Mempool analizi
  const mempoolStats = await analyzaMempool();
  
  // 3. Tarihsel veri
  const historicalGas = await getLast200Blocks();
  
  // 4. Kullanıcı tercihi
  const userPriority = getUserSetting(); // slow/normal/fast
  
  // 5. Hesaplama
  if (userPriority === 'slow') {
    return baseFee + 1; // Minimum priority fee
  } else if (userPriority === 'normal') {
    return baseFee + mempoolStats.avgPriorityFee;
  } else {
    return baseFee + mempoolStats.percentile90;
  }
}
```

### 7. Kullanıcıya Gösterilen UI

```
┌─────────────────────────────────┐
│         Gas Ayarları            │
├─────────────────────────────────┤
│ 🐌 Yavaş (5-30 dk)              │
│    31 Gwei - $1.20              │
│                                 │
│ ⚡ Normal (1-3 dk) [Seçili]     │
│    35 Gwei - $1.40              │
│                                 │
│ 🚀 Hızlı (15-30 sn)             │
│    45 Gwei - $1.80              │
├─────────────────────────────────┤
│ Gelişmiş Ayarlar ▼              │
│ Max Base Fee: [35] Gwei         │
│ Priority Fee: [2] Gwei          │
│ Gas Limit: [71,500]             │
└─────────────────────────────────┘
```

### 8. Cüzdanların Kullandığı Servisler

**Gas Tahmin Servisleri:**
- **ETH Gas Station API:** Tarihsel veri analizi
- **Blocknative Gas Platform:** Gerçek zamanlı mempool
- **1inch Gas Price API:** DeFi odaklı tahmin
- **Flashbots Protect:** MEV korumalı gas tahmini
- **Infura Gas API:** MetaMask'ın varsayılan servisi

**Örnek API Çağrısı:**
```json
// https://api.blocknative.com/gasprices/blockprices
{
  "blockNumber": 18500000,
  "baseFeePerGas": 30.5,
  "estimatedPrices": [
    {
      "confidence": 99,
      "price": 33,
      "maxPriorityFeePerGas": 2.5,
      "maxFeePerGas": 35
    }
  ]
}
```

## Faydalı Araçlar

1. **Gas Takip:**
   - Etherscan Gas Tracker
   - ETH Gas Station
   - Blocknative Gas Estimator

2. **Gas Hesaplama:**
   - Ethereum Gas Calculator
   - DeFi Saver Gas Price Extension

3. **İşlem Hızlandırma:**
   - MetaMask Speed Up özelliği
   - Flashbots Protect RPC