# Ethereum Yellow Paper Teknik Özeti

Ethereum Yellow Paper, **Dr. Gavin Wood** tarafından **2014 yılında** yazılan ve Ethereum protokolünün resmi teknik spesifikasyonunu içeren temel bir dokümandır. "Ethereum: A Secure Decentralised Generalised Transaction Ledger" başlığını taşıyan bu belge, Ethereum'un matematiksel ve teknik referans kaynağı olarak hizmet verir.

## Yellow Paper Nedir ve Amacı

Yellow Paper, Ethereum protokolünün **formal teknik spesifikasyonu**dur. Vitalik Buterin'in vizyoner White Paper'ının aksine, bu belge Ethereum'un nasıl çalıştığının kesin matematiksel tanımını sağlar. **Creative Commons CC-BY-SA 4.0 lisansı** altında yayınlanan belge, şu anda Shanghai network güncellemesine kadar (Nisan 2023, blok 17,034,870) olan Ethereum spesifikasyonunu yansıtır.

Belgenin temel amacı, herhangi bir geliştiricinin tam uyumlu bir Ethereum istemcisi (client) uygulayabilmesi için gerekli tüm teknik detayları sağlamaktır. Bu sayede **Geth** (Go), **Erigon** (Rust), **Besu** (Java) gibi farklı programlama dillerinde yazılmış birden fazla Ethereum istemcisinin aynı protokolü takip ederek konsensüs içinde çalışması mümkün olmuştur.

## Temel Teknik Bileşenler

### Ethereum Sanal Makinesi (EVM)

EVM, Ethereum'un hesaplama motoru olarak **256-bit kelime boyutuna sahip, yığın tabanlı (stack-based) bir sanal makinedir**. "Quasi-Turing complete" olarak tasarlanan EVM, sonsuz döngüleri önleyen gas mekanizması sayesinde güvenli bir şekilde çalışır.

EVM'nin bellek modeli üç ana bileşenden oluşur: geçici veriler için **uçucu (volatile) bellek**, kalıcı durum bilgisi için **depolama (storage)**, ve güvenlik amacıyla Von Neumann mimarisinden saparak program kodu için ayrı bir **salt okunur bellek (ROM)**. Yığın yapısı LIFO (Last-In-First-Out) prensibine göre çalışır ve maksimum 1024 öğe tutabilir. EVM, aritmetik işlemler, karşılaştırma, bitwise mantık, çevresel bilgi erişimi ve sistem operasyonlarını kapsayan kapsamlı bir **opcode** (işlem kodu) setine sahiptir.

### Durum Geçiş Fonksiyonları

Ethereum'un durum geçiş mekanizması **σ' = Υ(σ, T)** formülüyle ifade edilir. Burada σ mevcut durumu, T işlemi (transaction), σ' ise yeni durumu temsil eder. **World state** (dünya durumu), 160-bit adresler ile hesap durumları arasındaki eşleştirmeyi Modified Merkle Patricia Trees kullanarak saklar.

Ethereum'da iki tip hesap bulunur: **Externally Owned Accounts (EOA)** kullanıcılar tarafından kontrol edilen hesaplardır ve nonce, bakiye, storageRoot ve codeHash alanlarını içerir. **Contract Accounts** ise EVM bytecode'u ve depolama alanı barındıran akıllı sözleşme hesaplarıdır. Tüm durum değişiklikleri kriptografik olarak doğrulanmış veri yapıları kullanılarak ağ bütünlüğü korunur.

### Gas Mekanizması

Gas mekanizması, Ethereum'un **sonsuz döngüleri önleyen ve hesaplama karmaşıklığını ölçen** temel güvenlik bileşenidir. Her opcode'un önceden belirlenmiş bir gas maliyeti vardır - örneğin ADD işlemi 3 gas, SHA3 işlemi 30 gas tüketir. Bir işlemin ETH cinsinden maliyeti **kullanılan gas × gas fiyatı** formülüyle hesaplanır.

**Gas limit** parametresi, bir işlemin tüketebileceği maksimum gas miktarını belirleyerek sistem kaynaklarının tükenmesini önler. Kullanılmayan gas kullanıcıya iade edilir ve depolama alanını temizleyen işlemler gas iadesi alabilir. Bu mekanizma, Ethereum ağının DoS saldırılarına karşı korunmasında kritik rol oynar.

### İşlem ve Blok Yapıları

Ethereum işlemleri, EIP-2718 standardına göre üç farklı tipte olabilir. **Tüm işlem tiplerinde ortak alanlar** şunlardır: type (işlem tipi), nonce (sıralı işlem sayacı), gasLimit (maksimum gas tüketimi), to (alıcı adresi, kontrat oluşturmada boş), value (transfer edilecek Wei miktarı), ve r,s (ECDSA imza bileşenleri).

Blok yapısı **15 alandan oluşan bir başlık** içerir. Bunlar arasında **parentHash** (önceki blok hash'i), **stateRoot** (işlemler sonrası durum ağacı kökü), **transactionsRoot** ve **receiptsRoot** (işlem ve makbuz ağaçları kökleri), **gasUsed/gasLimit** (gas tüketim metrikleri), ve **baseFeePerGas** (EIP-1559 temel ücreti) bulunur. Shanghai güncellemesiyle **withdrawalsRoot** alanı da eklenmiştir.

## Matematiksel Formülasyonlar ve Formal Spesifikasyonlar

Yellow Paper, protokolün her yönünü kesin matematiksel notasyonla tanımlar. **Durum geçişi** σt+1 ≡ Υ(σt, T) formülüyle, **blok işleme** Π(σ, B) ≡ Υ(Υ(σ, T0), T1)... şeklinde ifade edilir. World state temsili için LS(σ) ≡ {p(a) : σ[a] ≠ ∅} notasyonu kullanılır.

**Merkle Patricia Tree** yapısı TRIE(I) ≡ KEC(RLP(c(I, 0))) formülüyle tanımlanır. Burada KEC, belge boyunca kullanılan **Keccak-256 hash fonksiyonunu** temsil eder. Bu matematiksel kesinlik, farklı implementasyonların aynı sonuçları üretmesini garanti eder.

## White Paper'dan Farkları

White Paper ile Yellow Paper arasındaki temel farklar, amaç ve hedef kitlede yatar. **White Paper**, 2013'te Vitalik Buterin tarafından yazılan, Ethereum'un vizyonunu ve kullanım alanlarını anlatan kavramsal bir belgedir. Genel kitleye hitap eder ve "ne" ve "neden" sorularına odaklanır.

**Yellow Paper** ise geliştiricilere yönelik, "nasıl" sorusunu cevaplayan teknik implementasyon kılavuzudur. White Paper felsefi ve iş modeli odaklıyken, Yellow Paper matematiksel spesifikasyonlar ve algoritmalar içerir. Bu ayrım, Ethereum'un hem vizyon hem de teknik uygulama açısından sağlam temellere oturmasını sağlamıştır.

## Ethereum Gelişimindeki Önemi

Yellow Paper'ın Ethereum ekosistemindeki önemi çok boyutludur. **Kesin referans standardı** olarak, protokol implementasyonu için otoriter kaynak görevi görür. Bu sayede farklı programlama dillerinde yazılmış birden fazla istemcinin ortak spesifikasyon üzerinden konsensüs sağlaması mümkün olmuştur.

**İstemci çeşitliliği**, ağın dayanıklılığını artırır. Tek bir implementasyondaki hata tüm ağı etkilemez. Farklı dillerde yazılmış istemciler sistematik hataları önler ve rekabetçi ortam optimizasyon ve iyileştirmeleri teşvik eder. Yellow Paper, **konsensüs mekanizmasının matematiksel çerçevesini** sağlayarak, fork seçim kurallarını ve doğrulama süreçlerini tanımlar.

Belge ayrıca **geliştirici araçları, analizörler ve test framework'lerinin** oluşturulmasına temel oluşturur. Formal doğrulama ve güvenlik analizi için matematiksel temel sağlar. EIP'lerin (Ethereum Improvement Proposals) implementasyonu için referans noktası olarak hizmet eder ve diğer blockchain projelerine de ilham kaynağı olmuştur.

## Sonuç

Ethereum Yellow Paper, blockchain teknolojisinde formal spesifikasyonun önemini gösteren çığır açıcı bir belgedir. **Matematiksel kesinliği** sayesinde Ethereum, en kapsamlı şekilde tanımlanmış blockchain protokollerinden biri haline gelmiştir. Bu durum, güçlü bir istemci, araç ve uygulama ekosisteminin gelişmesini sağlarken, ağ konsensüsü ve güvenliğinin korunmasını mümkün kılmıştır. Geliştiriciler için vazgeçilmez bir kaynak olan Yellow Paper, Ethereum'un teknik temellerini anlamak isteyen herkes için kritik bir referans belgesidir.