# IPFS (InterPlanetary File System) Nedir?

## Protokol Nedir?
Protokol, iki veya daha fazla cihazın birbiriyle nasıl iletişim kuracağını belirleyen kurallar bütünüdür. Tıpkı insanların anlaşabilmesi için ortak bir dil kullanması gibi, bilgisayarlar da veri alışverişi için protokollere ihtiyaç duyar.

### İnternet Protokolleri
- **HTTP/HTTPS**: Web sayfalarının görüntülenmesi için kullanılır (merkezi)
- **FTP**: Dosya transferi protokolü (merkezi)
- **SMTP/POP3/IMAP**: E-posta protokolleri (merkezi)
- **TCP/IP**: İnternetin temel iletişim protokolü
- **DNS**: Alan adlarını IP adreslerine çeviren sistem (hiyerarşik)

### P2P (Peer-to-Peer) Protokoller
- **BitTorrent**: Dosya paylaşımı için kullanılır
- **Bitcoin Protokolü**: Kripto para transferi için blockchain tabanlı
- **IPFS**: Dağıtık dosya depolama ve paylaşım protokolü
- **Ethereum**: Smart contract'lar için blockchain protokolü

### Protokoller Nasıl Çalışır?
1. **Handshake (El Sıkışma)**: İki cihaz iletişime başlamadan önce birbirini tanır
2. **Veri Formatı**: Gönderilecek verinin nasıl paketleneceği belirlenir
3. **İletim Kuralları**: Verinin nasıl gönderileceği, hata kontrolü yapılacağı tanımlanır
4. **Sonlandırma**: İletişimin nasıl sonlandırılacağı belirlenir

## Giriş
IPFS, internet üzerinde veri depolama ve paylaşma için geliştirilmiş dağıtık (decentralized) bir protokoldür. Geleneksel merkezi sunucu sistemlerinin aksine, IPFS verileri dünya çapında binlerce bilgisayar arasında dağıtarak saklar.

## IPFS ve Blockchain İlişkisi

### Benzerlikler
- **Dağıtık Yapı**: Her ikisi de merkezi bir otoriteye ihtiyaç duymaz
- **P2P (Peer-to-Peer) Ağ**: Kullanıcılar doğrudan birbirleriyle iletişim kurar
- **Kriptografik Hash**: Veriler benzersiz hash değerleriyle tanımlanır
- **Değiştirilemezlik**: Bir kere eklenen içerik hash değeri sayesinde değiştirilemez

### Temel Farklar
- **Blockchain**: İşlem geçmişini saklar, her blok öncekine bağlıdır
- **IPFS**: Dosya ve veri depolama odaklıdır, blok zinciri yapısı yoktur
- **Blockchain**: Konsensüs mekanizması gerektirir (PoW, PoS vb.)
- **IPFS**: Konsensüs gerektirmez, sadece içerik dağıtımı yapar

## IPFS Nasıl Çalışır?

### 1. İçerik Adresleme
Geleneksel web'de dosyalar sunucu konumuna göre bulunur (örn: www.site.com/dosya.pdf). IPFS'te ise dosyalar içeriğinin hash değeriyle bulunur:
- Her dosya benzersiz bir hash alır (örn: QmXgZAUWd8yo4tvjBETqzUy3wLx5YRzuDwUQnBwRGrAmAo)
- Aynı içeriğe sahip dosyalar aynı hash'i alır
- İçerik değişirse hash de değişir

### 2. Dağıtık Depolama
- Dosyalar parçalara bölünür
- Her parça farklı node'larda (düğümlerde) saklanabilir
- Popüler içerikler daha fazla node'da bulunur (cache mekanizması)

### 3. Veri Alışverişi
1. Kullanıcı bir dosya hash'i ile arama yapar
2. IPFS ağı bu hash'e sahip node'ları bulur
3. En yakın veya en hızlı node'dan dosya indirilir
4. İndirilen dosya otomatik olarak sizin node'unuzda da saklanır

## Avantajları

### 1. Sansüre Dayanıklılık
- Merkezi sunucu olmadığı için tek noktadan kapatılamaz
- Birden fazla kopyası olan içerik her zaman erişilebilir

### 2. Hız ve Verimlilik
- En yakın node'dan indirme yapılır
- Popüler içerikler daha hızlı erişilir (CDN benzeri)
- Bant genişliği tasarrufu sağlar

### 3. Kalıcılık
- Dosyalar hash ile tanımlandığı için değiştirilemez
- Versiyon kontrolü doğal olarak sağlanır

### 4. Maliyet
- Merkezi sunucu maliyeti yoktur
- Kullanıcılar kendi depolama alanlarını paylaşır

## Dezavantajları

### 1. Kalıcılık Garantisi Yok
- Eğer kimse bir dosyayı saklamazsa kaybolabilir
- "Pinning" servisleri bu sorunu çözmeye çalışır

### 2. İlk Erişim Yavaş Olabilir
- Nadir bulunan içeriklere erişim zaman alabilir
- Az popüler içerikler için performans düşük

### 3. Depolama Maliyeti
- Her kullanıcı başkalarının verilerini de saklar
- Disk alanı gereksinimi artabilir

## Kullanım Alanları

### 1. Web3 ve DApp'ler
- Blockchain uygulamalarının frontend'i IPFS'te barındırılır
- NFT metadata ve görselleri IPFS'te saklanır

### 2. Veri Arşivleme
- Wikipedia, bilimsel makaleler gibi önemli verilerin yedeklenmesi
- Sansüre karşı dirençli içerik paylaşımı

### 3. Dağıtık Web Hosting
- Statik websiteleri IPFS üzerinde barındırma
- Merkezi olmayan sosyal medya platformları

### 4. Büyük Dosya Paylaşımı
- Video, yazılım dağıtımı
- P2P dosya paylaşımının modern versiyonu

## IPFS ve Blockchain Entegrasyonu

### Filecoin
- IPFS üzerine inşa edilmiş blockchain projesi
- Depolama sağlayıcılara kripto para ile ödeme yapılır
- Kalıcılık problemini ekonomik teşviklerle çözer

### Smart Contract Entegrasyonu
- Ethereum smart contract'ları IPFS hash'lerini saklayabilir
- Büyük veriler blockchain yerine IPFS'te, referansları blockchain'de tutulur
- Gas fee tasarrufu sağlar

## IPFS Node'u Kimler Kurabilir?

### Kimler Kurabilir?
- **Bireysel Kullanıcılar**: Herhangi bir bilgisayar kullanıcısı
- **Geliştiriciler**: DApp ve Web3 projeleri için
- **Kurumlar**: Veri yedekleme ve dağıtım için
- **Üniversiteler**: Araştırma ve arşivleme için
- **İçerik Üreticileri**: Sansürsüz içerik paylaşımı için
- **Aktivistler**: Sansüre karşı dirençli yayıncılık için

### Node Kurmanın Avantajları
1. **Veri Kontrolü**: Kendi verilerinizin tam kontrolü
2. **Hızlı Erişim**: Lokal node'dan anında erişim
3. **Katkıda Bulunma**: IPFS ağını güçlendirme
4. **Özel Gateway**: Kendi gateway'inizi kullanabilme
5. **Gizlilik**: Üçüncü parti gateway'lere bağımlı olmama
6. **Öğrenme**: Dağıtık sistemleri deneyimleme

### Node Kurmanın Dezavantajları
1. **Depolama Kullanımı**: Disk alanı gereksinimi (varsayılan 10GB cache)
2. **Bant Genişliği**: Sürekli veri alışverişi
3. **Güvenlik Riskleri**: Açık portlar ve firewall ayarları
4. **Teknik Bilgi**: Kurulum ve yönetim bilgisi gerekir
5. **Elektrik Tüketimi**: 7/24 çalışan bilgisayar
6. **IP Görünürlüğü**: IP adresiniz ağda görünür

## En Popüler IPFS Node'ları ve Servisler

### Public Gateway'ler
1. **ipfs.io**: Protocol Labs'ın resmi gateway'i
2. **cloudflare-ipfs.com**: Cloudflare'in hızlı gateway'i
3. **gateway.pinata.cloud**: Pinata'nın gateway'i
4. **dweb.link**: Protocol Labs alternatif gateway
5. **infura.io**: Ethereum ve IPFS altyapısı
6. **fleek.co**: Web3 hosting platformu

### Pinning Servisleri (Kalıcı Depolama)

#### Pinning Nedir?
IPFS'te dosyalar varsayılan olarak geçici önbellekte (cache) tutulur ve alan gerektiğinde silinebilir. **Pinning**, bir dosyanın kalıcı olarak saklanmasını sağlayan işlemdir. "Pin" edilmiş dosyalar garbage collection (çöp toplama) işleminde silinmez ve her zaman node'da kalır. Pinning servisleri, sizin için dosyalarınızı 7/24 çalışan sunucularda "pinleyerek" kalıcı olarak saklar ve erişilebilir tutar.

#### Neden Pinning Gerekli?
- **Kalıcılık**: Dosyalarınız sürekli erişilebilir kalır
- **Güvenilirlik**: Profesyonel altyapıda yedekleme
- **Erişilebilirlik**: Kendi bilgisayarınız kapalıyken bile dosyalar aktif
- **Performans**: Hızlı sunuculardan global erişim

1. **Pinata**: En popüler pinning servisi
   - Ücretsiz: 1GB depolama
   - Ücretli: Sınırsız depolama
   
2. **Infura IPFS**: ConsenSys tarafından işletilir
   - Ethereum ile entegre
   - Kurumsal çözümler
   
3. **Web3.Storage**: Protocol Labs & Filecoin
   - Ücretsiz depolama (Filecoin destekli)
   - Otomatik Filecoin yedekleme
   
4. **NFT.Storage**: NFT'ler için özel
   - Tamamen ücretsiz
   - NFT metadata için optimize
   
5. **Fleek**: DApp hosting
   - IPFS + CDN kombinasyonu
   - Otomatik SSL sertifikaları

### Kurumsal Node'lar
- **Netflix**: Video içerik dağıtımı denemeleri
- **Cloudflare**: Dağıtık web altyapısı
- **Opera Browser**: Dahili IPFS desteği
- **Brave Browser**: Native IPFS entegrasyonu
- **Microsoft ION**: DID (Kimlik) sistemi için

## Teknik Detaylar

### IPFS Node Kurulumu
```bash
# IPFS indirme (MacOS/Linux)
wget https://dist.ipfs.io/go-ipfs/v0.18.0/go-ipfs_v0.18.0_linux-amd64.tar.gz
tar -xvzf go-ipfs_v0.18.0_linux-amd64.tar.gz
cd go-ipfs
sudo bash install.sh

# IPFS başlatma
ipfs init

# Depolama limitini ayarlama
ipfs config Datastore.StorageMax 20GB

# IPFS daemon başlatma
ipfs daemon

# Dosya ekleme
ipfs add dosya.txt

# Dosya alma
ipfs get QmHash...

# Web UI erişimi
http://localhost:5001/webui

# Peer listesi görme
ipfs swarm peers

# Node bilgileri
ipfs id
```

### Node Türleri
1. **Full Node**: Tüm IPFS özelliklerini çalıştırır
2. **Light Node**: Sınırlı depolama ve bant genişliği
3. **Gateway Node**: Sadece HTTP gateway hizmeti
4. **Pinning Node**: Belirli içerikleri kalıcı saklar
5. **Cluster Node**: Birden fazla node'u koordine eder

### Minimum Sistem Gereksinimleri
- **İşlemci**: 2 GHz dual-core
- **RAM**: 2 GB (önerilen 4 GB)
- **Depolama**: 10 GB boş alan (önerilen 50+ GB)
- **Bant Genişliği**: 10 Mbps (önerilen 100 Mbps)
- **İşletim Sistemi**: Linux, macOS, Windows
- **Açık Portlar**: 4001 (Swarm), 5001 (API), 8080 (Gateway)

### IPFS Gateway'ler
- IPFS içeriğine normal tarayıcıdan erişim sağlar
- Örnek: https://ipfs.io/ipfs/QmHash...
- Merkezi gateway'ler geçici çözümdür

## Gelecek ve Potansiyel

### Web 3.0'ın Temeli
- Merkezi olmayan internet altyapısının önemli parçası
- Kullanıcı verilerinin kontrolü kullanıcıda

### Veri Egemenliği
- Şirketlerin veri tekelini kırar
- Açık ve şeffaf veri paylaşımı

### Gelişen Ekosistem
- Brave, Opera gibi tarayıcılar native IPFS desteği sunuyor
- Artan geliştirici ve kullanıcı topluluğu

## Özet
IPFS, blockchain'in dağıtık felsefesini veri depolama alanına taşıyan devrim niteliğinde bir teknolojidir. Blockchain işlem kayıtlarını saklarken, IPFS dosya ve verileri dağıtık olarak depolar. İkisi birlikte kullanıldığında tam anlamıyla merkezi olmayan uygulamalar (DApp) geliştirmek mümkün hale gelir. IPFS henüz gelişme aşamasında olsa da, merkezi internet yapısına güçlü bir alternatif sunmaktadır.