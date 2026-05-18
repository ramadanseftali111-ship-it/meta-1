# 🚀 STOCADO ENTEGRASYONU KURULUM REHBERİ

## ✅ NE YAPILDI?

Firebase Cloud Functions ile Stocado API entegrasyonu tamamlandı!

**Nasıl Çalışır:**
1. Müşteri sipariş verir
2. Sipariş Firebase'e kaydedilir
3. **Cloud Function otomatik tetiklenir** (sunucu tarafında)
4. Stocado API'sine login yapılır (JWT token alınır)
5. Sipariş Stocado'ya aktarılır
6. Sen Stocado panelinden göreceksin ve kargo firmasını seçeceksin

**Artık CORS sorunu yok!** ✅

---

## 📦 KURULUM ADIMLARI

### 1. Firebase CLI Kur

```bash
npm install -g firebase-tools
```

### 2. Firebase'e Login Ol

```bash
firebase login
```

### 3. Firebase Projesini Seç

```bash
firebase use --add
```
(Projenizi seçin: örn. `benim-sitem-12345`)

### 4. Functions Klasörüne Git ve Paketleri Yükle

```bash
cd functions
npm install
cd ..
```

### 5. Cloud Functions'ı Deploy Et

```bash
firebase deploy --only functions
```

Deploy tamamlandığında şu mesajı göreceksiniz:
```
✔  Deploy complete!

Functions:
  - onNewOrder(us-central1)
  - testStocadoConnection(us-central1)
```

---

## 🧪 TEST ET

### Test 1: HTTP Endpoint ile Test

Deploy sonrası verilen URL'i tarayıcıda aç:
```
https://REGION-PROJECT_ID.cloudfunctions.net/testStocadoConnection
```

Başarılı ise şunu göreceksin:
```json
{
  "success": true,
  "message": "✅ Stocado bağlantısı başarılı!",
  "token": "eyJhbGciOiJIUzI1NiIs...",
  "cargoResult": { ... }
}
```

### Test 2: Gerçek Sipariş ile Test

1. Sitenizden bir test siparişi verin
2. Firebase Console'a git: https://console.firebase.google.com
3. **Functions** → **Logs** bölümüne bak
4. Şu logları göreceksin:
   - `🆕 Yeni sipariş geldi!`
   - `🔐 Stocado'ya login yapılıyor...`
   - `✅ Token alındı`
   - `📦 Stocado'ya kargo oluşturuluyor...`
   - `✅ Sipariş Stocado'ya başarıyla aktarıldı!`

5. **Stocado paneline git** ve siparişi gör!

---

## 📋 STOCADO PANELİNDE NE GÖRECEKSIN?

Stocado panelinde yeni kargo göreceksin:
- **Alıcı:** Müşteri adı, telefon, adres
- **Açıklama:** `Sipariş #12345 - Forum 1`
- **Desi:** 1 (varsayılan)
- **Durum:** Kargo firması seçilmemiş

**Sen yapacaksın:**
1. Kargo firmasını seç (Yurtiçi, Aras, MNG vs.)
2. Kargoyu gönder

---

## 🔧 AYARLAR

### Şifre Değiştirme

Eğer Stocado şifrenizi değiştirirseniz:

1. `functions/index.js` dosyasını aç
2. Şu satırı bul:
   ```javascript
   const STOCADO_PASSWORD = 'ramadan123R';
   ```
3. Yeni şifreyi yaz
4. Tekrar deploy et:
   ```bash
   firebase deploy --only functions
   ```

### Gönderici Adresi Ekleme

Eğer Stocado'da gönderici adresinizi kaydettiyseniz ve ID'sini biliyorsanız:

1. `functions/index.js` dosyasını aç
2. `cargoPayload` içine ekle:
   ```javascript
   sender_id: "GONDERICI_ADRES_ID",
   ```
3. Deploy et

### Desi Hesaplama

Şu anda varsayılan desi: **1**

Eğer ürünlere göre desi hesaplamak istersen:
- Ürün veritabanına `desi` alanı ekle
- Sipariş kaydederken desi'yi de kaydet
- Cloud Function otomatik alır

---

## 📊 LOGLAR NASIL GÖRÜLÜR?

### Firebase Console'dan:
1. https://console.firebase.google.com
2. Projenizi seçin
3. **Functions** → **Logs**

### Terminal'den:
```bash
firebase functions:log
```

---

## ❌ HATA DURUMUNDA

Eğer sipariş Stocado'ya gitmezse:

1. **Firebase Logs'a bak** (yukarıda anlattık)
2. Hata mesajını oku
3. Olası hatalar:
   - `Login failed` → Şifre yanlış
   - `Kargo oluşturulamadı` → API formatı hatalı
   - `Token expired` → Token süresi dolmuş (otomatik yenilenir)

4. Firebase'de sipariş verisine bak:
   ```
   /siparisler/forum1/SIPARIS_ID
   ```
   Şu alanları göreceksin:
   - `stocadoCargoId` → Başarılı ise kargo ID'si
   - `stocadoStatus` → "created" veya "failed"
   - `stocadoError` → Hata mesajı (varsa)

---

## 💰 MALİYET

Firebase Cloud Functions:
- **İlk 2 milyon çağrı/ay:** ÜCRETSİZ
- **Sonrası:** $0.40 / milyon çağrı

Örnek: Ayda 1000 sipariş = Tamamen ücretsiz ✅

---

## 🎉 TAMAMLANDI!

Artık siparişler otomatik olarak Stocado'ya aktarılacak!

**Sorular:**
- Firebase Console'da logları kontrol et
- Test siparişi ver ve Stocado'da gör
- Herhangi bir sorun olursa logları paylaş

**Başarılar! 🚀**
