# Blockchain Node'ları: Kapsamlı Rehber

## Node (Düğüm) Nedir?

Blockchain node'u, bir blockchain ağının parçası olan ve blockchain'in bir kopyasını saklayan bilgisayardır. Her node, ağdaki diğer node'larla iletişim kurarak işlemleri doğrular, yeni blokları yayar ve ağın güvenliğini sağlar.

### Temel Özellikleri:
- **Dağıtık Yapı**: Her node, blockchain'in tam veya kısmi kopyasını tutar
- **P2P İletişim**: Node'lar birbirleriyle doğrudan iletişim kurar (merkezi sunucu yok)
- **Konsensüs Katılımı**: Ağın kurallarını uygular ve doğrulama yapar

## Node Tipleri

### 1. Full Node (Tam Düğüm)
**Özellikler:**
- Blockchain'in tüm geçmişini saklar (genesis block'tan günümüze)
- Tüm işlemleri ve blokları bağımsız olarak doğrular
- Ağ kurallarını tam olarak uygular
- Diğer node'lara veri sağlayabilir

**Teknik Gereksinimler:**
- Yüksek depolama alanı (Bitcoin: ~500GB, Ethereum: ~1TB+)
- Sürekli internet bağlantısı
- Yeterli RAM ve işlemci gücü

### 2. Light Node (Hafif Düğüm)
**Özellikler:**
- Sadece block header'ları saklar
- İşlem doğrulaması için full node'lara güvenir
- Simplified Payment Verification (SPV) kullanır
- Mobil cihazlar için idealdir

**Avantajları:**
- Düşük depolama gereksinimi (<1GB)
- Hızlı senkronizasyon
- Minimal kaynak kullanımı

### 3. Archive Node (Arşiv Düğümü)
**Özellikler:**
- Full node'un tüm özelliklerine sahiptir
- Ek olarak tüm tarihi state'leri saklar
- Geçmiş herhangi bir bloktaki durumu sorgulayabilir

**Kullanım Alanları:**
- Blockchain analitiği
- DApp geliştirme
- Geçmiş veri sorgulamaları

### Full Node vs Archive Node: Detaylı Karşılaştırma

#### Full Node Ne Tutar?
Full node'lar şunları saklar:
- **Tüm bloklar**: Genesis'ten günümüze tüm blok verileri (header + transaction)
- **Güncel state**: Sadece SON durum (current state)
- **Son ~128 bloğun state'i**: Yakın geçmiş için state verileri (reorg durumları için)

#### Archive Node Ne Tutar?
Archive node'lar şunları saklar:
- **Tüm bloklar**: Full node gibi
- **TÜM tarihi state'ler**: Her blok yüksekliğindeki state snapshot'ları
- **Ara state'ler**: İşlemler arası state değişimleri

#### Pratik Örnek - Ethereum'da Fark:

**Senaryo**: 1 Ocak 2020'de bir adresin bakiyesini sorgulamak istiyorsunuz.

**Full Node:**
```javascript
// Full Node - ÇALIŞMAZ
web3.eth.getBalance("0xABC...", blockNumber_2020) 
// Hata: State not available
// Full node sadece güncel bakiyeyi verebilir
web3.eth.getBalance("0xABC...") // ✓ Çalışır (güncel)
```

**Archive Node:**
```javascript
// Archive Node - ÇALIŞIR
web3.eth.getBalance("0xABC...", blockNumber_2020) // ✓ Çalışır
// 2020'deki bakiyeyi döndürür
```

#### State Pruning (Budama) Nedir?
Full node'lar disk alanı tasarrufu için **state pruning** yapar:
- Eski state'leri siler (sadece blok verisi kalır)
- Son 128-1024 blok state'ini tutar (ayarlanabilir)
- Güncel state'i her zaman tutar

**Pruning Örneği:**
```
Blok 1000: State A → Full node bunu SİLER
Blok 2000: State B → Full node bunu SİLER  
Blok 9000: State C → Full node bunu SİLER
Blok 9900: State D → Son 128 blok içinde, TUTAR
Blok 10000: State E → Güncel state, TUTAR
```

#### Depolama Gereksinimleri:

**Bitcoin:**
- Full Node: ~500 GB (sadece bloklar + UTXO set)
- Archive Node: Bitcoin'de state kavramı farklı, UTXO bazlı

**Ethereum:**
- Full Node: ~1 TB (bloklar + güncel state)
- Archive Node: ~15+ TB (bloklar + TÜM state'ler)

#### Ne Zaman Hangisine İhtiyaç Var?

**Full Node Yeterli:**
- Güncel bakiye sorgulamaları
- Yeni işlem gönderme
- Güncel smart contract çağrıları
- Blok doğrulama
- Ağ güvenliğine katkı

**Archive Node Gerekli:**
- Geçmiş bakiye sorgulamaları
- Tarihi smart contract state'leri
- Blockchain analitiği/explorer servisleri
- Tarihi event log sorgulamaları
- Vergi raporlaması
- Forensik analiz

### 4. Mining/Validator Node (Madenci/Doğrulayıcı Düğüm)
**Özellikler:**
- Yeni bloklar üretir
- İşlemleri bloklara dahil eder
- Konsensüs mekanizmasına aktif katılım sağlar

## Bitcoin Ekosistemindeki Roller

### Bitcoin Core Node
```
Temel Görevler:
├── İşlem Doğrulama
│   ├── UTXO kontrolü
│   ├── İmza doğrulama
│   └── Double-spending kontrolü
├── Blok Doğrulama
│   ├── Proof-of-Work kontrolü
│   ├── Merkle tree doğrulama
│   └── Blok boyutu/format kontrolü
└── Ağ Güvenliği
    ├── Konsensüs kuralları uygulama
    └── Fork durumunda karar verme
```

### Bitcoin'de Node Çalıştırma
```bash
# Bitcoin Core kurulumu
bitcoind -daemon  # Node'u başlat
bitcoin-cli getblockcount  # Blok yüksekliğini kontrol et
bitcoin-cli getpeerinfo  # Bağlı peer'ları görüntüle
```

**Önemli Parametreler:**
- **Mempool**: Onaylanmamış işlemlerin geçici havuzu
- **UTXO Set**: Harcanmamış işlem çıktıları veritabanı
- **Chainstate**: Mevcut blockchain durumu

## Ethereum Ekosistemindeki Roller

### Ethereum Node Yapısı
Ethereum'da node'lar iki katmandan oluşur:

#### 1. Execution Layer (Çalıştırma Katmanı)
**Görevler:**
- Smart contract'ları çalıştırma
- EVM (Ethereum Virtual Machine) işlemleri
- State transition hesaplamaları

**Popüler Client'lar:**
- Geth (Go Ethereum)
- Nethermind
- Besu
- Erigon

#### 2. Consensus Layer (Konsensüs Katmanı)
**Görevler:**
- Proof-of-Stake konsensüsü
- Validator koordinasyonu
- Finality sağlama

**Popüler Client'lar:**
- Prysm
- Lighthouse
- Teku
- Nimbus

### Ethereum Node Kurulumu Örneği
```bash
# Geth execution client
geth --syncmode "snap" --http --http.api eth,net,web3

# Lighthouse consensus client  
lighthouse beacon_node \
  --network mainnet \
  --execution-endpoint http://localhost:8551 \
  --execution-jwt /path/to/jwt.hex
```

### Ethereum'da Node Tipleri ve Sync Modları

#### 1. Full Sync
- Tüm blokları genesis'ten itibaren işler
- Her işlemi yeniden çalıştırır
- En güvenli ama en yavaş

#### 2. Fast Sync (Snap Sync)
- State'i peer'lardan indirir
- Son binlerce bloğu doğrular
- Daha hızlı senkronizasyon

#### 3. Light Sync
- Sadece block header'ları indirir
- State için diğer node'lara güvenir

## Teknik Detaylar

### Node İletişim Protokolleri

#### Bitcoin: P2P Protokolü
```
Mesaj Tipleri:
├── version: Node versiyonu ve yetenekleri
├── verack: Version onayı
├── inv: Envanter bildirimi (tx, block)
├── getdata: Veri talebi
├── block: Blok verisi
├── tx: İşlem verisi
└── ping/pong: Bağlantı kontrolü
```

#### Ethereum: DevP2P ve ETH Protokolü
```
Katmanlar:
├── RLPx: Şifreli transport
├── DevP2P: Node keşfi ve bağlantı yönetimi
└── ETH Wire Protocol: Blockchain verisi değişimi
    ├── Status: Chain durumu paylaşımı
    ├── NewBlockHashes: Yeni blok bildirimi
    ├── Transactions: İşlem yayını
    └── GetBlockHeaders: Header talebi
```

### Node Güvenlik Önlemleri

1. **DDoS Koruması**
   - Rate limiting
   - Peer reputation sistemi
   - Ban listesi yönetimi

2. **Eclipse Attack Koruması**
   - Çeşitli peer bağlantıları
   - Outbound bağlantı tercihi
   - IP çeşitliliği

3. **Sybil Attack Koruması**
   - Peer ID doğrulama
   - Proof-of-Work handshake (bazı ağlarda)

## Node Çalıştırmanın Önemi

### Ağ İçin Faydaları
- **Merkeziyetsizlik**: Daha fazla node = daha güçlü ağ
- **Güvenlik**: Saldırılara karşı direnç
- **Erişilebilirlik**: Veri dağıtımı ve redundancy

### Kullanıcı İçin Faydaları
- **Gizlilik**: Kendi işlemlerinizi doğrulama
- **Güven**: Üçüncü taraflara bağımlı olmama
- **Katılım**: Ağ yönetiminde söz sahibi olma

## Performans Metrikleri

### İzlenmesi Gereken Parametreler
```
Node Sağlığı:
├── Block Height: Senkronizasyon durumu
├── Peer Count: Bağlı node sayısı
├── Mempool Size: Bekleyen işlem sayısı
├── CPU/RAM Kullanımı: Sistem kaynakları
├── Disk I/O: Okuma/yazma hızları
└── Network Bandwidth: Veri trafiği
```

## Sonuç

Blockchain node'ları, merkeziyetsiz ağların temel yapı taşlarıdır. Her node tipi farklı kaynak gereksinimleri ve sorumluluklar taşır. Full node'lar ağın güvenliğini sağlarken, light node'lar kullanıcı erişimini kolaylaştırır. Bitcoin ve Ethereum ekosistemlerinde node'lar benzer prensiplerle çalışsa da, her ağın kendine özgü protokolleri ve gereksinimleri vardır.

Node çalıştırmak, blockchain ağlarına aktif katılımın en temel yoludur ve ağın merkeziyetsizliğini korumak için kritik öneme sahiptir.

BİR BLOKZİNCİRDE NODE KURMAK NE KADAR ZAHMETLİ İSE O BLOKZİNCİR O KADAR MERKEZİDİR. 