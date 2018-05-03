# KÜTÜPHANEYİ PROJEYE EKLEME

ekomesajapi klasörünü XCode projenizin üzerine sürükleyin.

![alt text](https://github.com/mobilisim/EkomesajIOSLibrary/blob/master/Image2.png?raw=true)


![alt text](https://github.com/mobilisim/EkomesajIOSLibrary/blob/master/Image1.png?raw=true)


# SUBMIT METODU
```swift
// SUBMIT
// Birden çok numraya aynı mesaj içeriği gönderilmesini sağlar.

// credential objesi API'ye ulaşabilmeniz için gerekli kullanıcı doğrulamasının yapıldığı alandır.
let credential = Credential(username: "Username", password: "Password")

let submit = Submit()

// header objesi başlık, ileri tarihli gönderim, geçerlilik süresi
let header = Header()

//Gönderen Adı / Başlık / [ZORUNLU]
header.from = "TESTSENDER"

//İleri tarihli gönderim yapılmak isteniyorsa girilmelidir. / [OPSİYONEL]
header.scheduledDeliveryTime = "2018-05-13T16:15:00Z"

//mesaj gönderimi başarısız ise 1440 dk boyunca tekrar denenecek ve bu süre sonunda artık gönderim denenmeyecektir.
//Bu alan gönderilmez veya 0 gönderilirse default değeri 1440 olarak alır.
//[OPSİYONEL]
header.validityPeriod = 0

submit.header = header

// Mesajın kodlanma biçimidir.
submit.dataCoding = DataCoding.Default

// gönderilecek mesaj içeriği / [ZORUNLU]
submit.message = "Test Message"

// telefon numaraları / [ZORUNLU]
submit.to = ["905998887766", "905998887755"]

let requestSubmit = RequestSubmit(credential: credential, submit: submit)
PostSubmit.post(requestSubmit: requestSubmit) { (response) in
    if(response.status.code == 200){
        print("MessageId: \(response.messageId)")
    }else{
        print("Code: \(response.status.code) Description: \(response.status.desc)")
    }
}

/////////////////////////////////////////
// gelen cevaplar ve anlamları.
/////////////////////////////////////////

// Status.
// Code ve Desc alanları yer alır. Mesajın sisteme başarılı şekilde gönderilip gönderilmediği bilgisini verir.
// Code = 200 ve Description = OK ise mesaj sisteme başarılı şekilde ulaşmıştır. Bu mesajın iletim durumu değildir.
// Alabileceği değerler için dokümana bakınız.

// MessageId
// Sistemden rapor alınması için geri dönen mesaj numarasıdır.
```

# SUBMITMULTI METODU
```swift
// SUBMITMULTI
// Birden çok numraya farklı mesaj içeriği gönderilmesini sağlar.
// Birden çok numaraya aynı içerik göndermek için SUBMIT kullanmanız gerekir.

// credential objesi API'ye ulaşabilmeniz için gerekli kullanıcı doğrulamasının yapıldığı alandır.
let credential = Credential(username: "Username", password: "Password")

let submitMulti = SubmitMulti()

// header objesi başlık, ileri tarihli gönderim, geçerlilik süresi
let header = Header()

//Gönderen Adı / Başlık / [ZORUNLU]
header.from = "TESTSENDER"

//İleri tarihli gönderim yapılmak isteniyorsa girilmelidir. / [OPSİYONEL]
header.scheduledDeliveryTime = "2018-05-13T16:15:00Z"

//mesaj gönderimi başarısız ise 1440 dk boyunca tekrar denenecek ve bu süre sonunda artık gönderim denenmeyecektir.
//Bu alan gönderilmez veya 0 gönderilirse default değeri 1440 olarak alır.
//[OPSİYONEL]
header.validityPeriod = 0

submitMulti.header = header

// Mesajın kodlanma biçimidir.
submitMulti.dataCoding = DataCoding.Default

// telefon numaraları ve mesajlar / [ZORUNLU]
let list:[Envelopes] = [Envelopes(to: "905998887766", message: "Test Message 1"), Envelopes(to: "905998887755", message: "Test Message 2")]
submitMulti.envelopes = list
        
let requestSubmitMulti = RequestSubmitMulti(credential: credential, submitMulti: submitMulti)
PostSubmitMulti.post(requestSubmitMulti: requestSubmitMulti) { (response) in
    if(response.status.code == 200){
        print("MessageId: \(response.messageId)")
    }else{
        print("Code: \(response.status.code) Description: \(response.status.desc)")
    }
}

/////////////////////////////////////////
// gelen cevaplar ve anlamları.
/////////////////////////////////////////

// Status.
// Code ve Desc alanları yer alır. Mesajın sisteme başarılı şekilde gönderilip gönderilmediği bilgisini verir.
// Code = 200 ve Description = OK ise mesaj sisteme başarılı şekilde ulaşmıştır. Bu mesajın iletim durumu değildir.
// Alabileceği değerler için dokümana bakınız.

// MessageId
// Sistemden rapor alınması için geri dönen mesaj numarasıdır.
```

# QUERY METODU
```swift
// QUERY
// MessageId veya MessageId + Telefon numarasına göre raporlama yapmanızı sağlar.

// credential objesi API'ye ulaşabilmeniz için gerekli kullanıcı doğrulamasının yapıldığı alandır.
let credential = Credential(username: "username", password: "password")

// messageId / [ZORUNLU]
let messageId = "111222333"

// ilgili pakette belirli bir numaranın raporlanması isteniyorsa girilir [OPSİYONEL]
let phoneNumber = ""

let requestQuery = RequestQuery(credential: credential, messageId: messageId, phoneNumber: phoneNumber)
PostQuery.post(requestQuery: requestQuery) { (response) in
    if(response.status.code == 200){
        for query in response.list {
            print("Id: \(query.id) Network: \(query.network) MSISDN: \(query.msisdn) Cost: \(query.cost) Submitted: \(query.submitted) LastUpdate: \(query.lastUpdate) State: \(query.state) Sequence: \(query.sequence) ErrorCode: \(query.errorCode) PayLoad: \(query.payLoad) Xser: \(query.xser) ")
        }
    }else{
        print("Code: \(response.status.code) Description: \(response.status.desc)")
    }
}

/////////////////////////////////////////
// gelen cevaplar ve anlamları.
/////////////////////////////////////////

// Status.
// Code ve Desc alanları yer alır. Mesajın sisteme başarılı şekilde gönderilip gönderilmediği bilgisini verir.
// Code = 200 ve Description = OK ise mesaj sisteme başarılı şekilde ulaşmıştır. Bu mesajın iletim durumu değildir.
// Alabileceği değerler için dokümana bakınız.

// Query
// Payload:    Mesaj içeriği.
// Xser:       UCP XSER değeri veya UDH SMPP değeri.
// Cost:       Mesaj ücreti.
// ErrorCode:  Hata kodu. Mesaj gönderiminde problem olursa bu alanda hata kodu döner.
// Id:         Bir pakette birden fazla veya tek mesaj bulunabilir. Mesajın paket içerisindeki Id numarasıdır.
// LastUpdated:Durum güncellemesinin yapıldığı son tarih. (UTC Time Zone)
// MSISDN:     Gönderilen telefon numarası.
// Network:    Mesajın gönderildiği operatör Id'si.
// Sequence:   Uzun/Birleşik mesajlarda burada her mesajın içeriği listelenir.
// State:      Mesaj durumu.
// Submitted:  Mesajın sisteme teslim edilme zamanıdır. (UTC Time Zone)
```

# QUERYMULTI METODU
```swift
// QUERYMULTI
// Tarih aralığına göre raporlama yapmanızı sağlar.

// credential objesi API'ye ulaşabilmeniz için gerekli kullanıcı doğrulamasının yapıldığı alandır.
let credential = Credential(username: "Username", password: "Password")

// Başlangıç Tarihi / [ZORUNLU]
let beginDate = "2018-03-01T12:23:00"

// Bitiş Tarihi / [ZORUNLU]
let endDate   = "2018-05-01T16:53:00"

let requestQueryMulti = RequestQueryMulti(credential: credential, beginDate: beginDate, endDate: endDate)
PostQueryMulti.post(requestQueryMulti: requestQueryMulti) { (response) in
    if(response.status.code == 200){
        for queryMulti in response.list {
            print("Id: \(queryMulti.id) Cost: \(queryMulti.cost) State: \(queryMulti.state) Count: \(queryMulti.count) Coding: \(queryMulti.coding) Message: \(queryMulti.message) Received: \(queryMulti.received) Sender: \(queryMulti.sender) Sent: \(queryMulti.sent) DeliveredCount: \(queryMulti.deliveredCount) UndeliveredCount: \(queryMulti.undeliveredCount)")
        }
    }else{
        print("Code: \(response.status.code) Description: \(response.status.desc)")
    }
}

/////////////////////////////////////////
// gelen cevaplar ve anlamları.
/////////////////////////////////////////

// Status.
// Code ve Desc alanları yer alır. Mesajın sisteme başarılı şekilde gönderilip gönderilmediği bilgisini verir.
// Code = 200 ve Description = OK ise mesaj sisteme başarılı şekilde ulaşmıştır. Bu mesajın iletim durumu değildir.
// Alabileceği değerler için dokümana bakınız.

// QueryMulti
// Cost:            Mesaj ücreti.
// Count:           Toplam mesaj sayısı.
// DeliveredCount:  Teslim edilen mesaj sayısı.
// UndeliveredCount:Teslim edilemeyen mesaj sayısı.
// Id:              Mesaj paket numarasıdır.
// Message:         Mesaj içeriği.
// Received:        Sistemin mesajı aldığı tarih. (UTC Time Zone)
// Sender:          Mesajı gönderen alfanumerik isim.
// Sent:            Mesajı gönderilme tarihi. (UTC Time Zone)
// State:           Mesaj paketinin durumu. Mesaj Paket Durumları
// Coding:          Mesajın kodlanma biçimidir. 3 değer alabilir;
```

# QUERYSTATS METODU
```java
// QUERYSTATS
// Aylık ve Yıllık teslimat rapor bilgilerini verir.

// credential objesi API'ye ulaşabilmeniz için gerekli kullanıcı doğrulamasının yapıldığı alandır.
let credential = Credential(username: "Username", password: "Password")

PostQueryStats.post(credential: credential) { (response) in
    if(response.status.code == 200){
        for queryStats in response.list {
            print("Year: \(queryStats.year) Month: \(queryStats.month) Delivered: \(queryStats.delivered) Undelivered: \(queryStats.undelivered) Count: \(queryStats.count)")
        }
    }else{
        print("Code: \(response.status.code) Description: \(response.status.desc)")
    }
}

/////////////////////////////////////////
// gelen cevaplar ve anlamları.
/////////////////////////////////////////

// Status.
// Code ve Desc alanları yer alır. Mesajın sisteme başarılı şekilde gönderilip gönderilmediği bilgisini verir.
// Code = 200 ve Description = OK ise mesaj sisteme başarılı şekilde ulaşmıştır. Bu mesajın iletim durumu değildir.
// Alabileceği değerler için dokümana bakınız.

// QueryStats
// Count:              Toplam gönderilen mesaj sayısı.
// Delivered:          Teslim edilen mesaj sayısı.
// UndeliveredCount:   Teslim edilemeyen mesaj sayısı.
// Month:              Rapor ay bilgisi.
// Year:               Rapor yıl bilgisi.
```

# LOGİN METODU
```swift
// LOGIN
// Kullanıcının kullanıcı adı ve parolasını doğrular.

// credential objesi API'ye ulaşabilmeniz için gerekli kullanıcı doğrulamasının yapıldığı alandır.
let credential = Credential(username: "username", password: "password")

PostLogin.post(credential: credential) { (response) in
    if(response.status.code == 200){
        print("UserId: \(response.userId)")
    }else{
        print("Code: \(response.status.code) Description: \(response.status.desc)")
    }
}

/////////////////////////////////////////
// gelen cevaplar ve anlamları.
/////////////////////////////////////////

// Status.
// Code ve Desc alanları yer alır. Mesajın sisteme başarılı şekilde gönderilip gönderilmediği bilgisini verir.
// Code = 200 ve Description = OK ise mesaj sisteme başarılı şekilde ulaşmıştır. Bu mesajın iletim durumu değildir.
// Alabileceği değerler için dokümana bakınız.

// UserId:    Ana Kredi. Sahip olduğunuz kredi adetidir.
```

# GETBALANCE METODU
```swift
// GETBALANCE
// Kredi durumunuzu gösterir.

// credential objesi API'ye ulaşabilmeniz için gerekli kullanıcı doğrulamasının yapıldığı alandır.
let credential = Credential(username: "username", password: "password")

GetBalance.post(credential: credential) { (response) in
    if(response.status.code == 200){
        print("Main: \(response.balance.main) Limit: \(response.balance.limit)")
    }else{
        print("Code: \(response.status.code) Description: \(response.status.desc)")
    }
}

/////////////////////////////////////////
// gelen cevaplar ve anlamları.
/////////////////////////////////////////

// Status.
// Code ve Desc alanları yer alır. Mesajın sisteme başarılı şekilde gönderilip gönderilmediği bilgisini verir.
// Code = 200 ve Description = OK ise mesaj sisteme başarılı şekilde ulaşmıştır. Bu mesajın iletim durumu değildir.
// Alabileceği değerler için dokümana bakınız.

// Main:    Ana Kredi. Sahip olduğunuz kredi adetidir.
// Limit:   Eksiye düşebileceğiniz kredi adetidir.
// Kullanılabilir Kredi:    total = main + limit;
```

# GETSETTING METODU
```swift
// GETSETTING
// Hesabınız ile ilgili bilgileri almanızı sağlar.

// credential objesi API'ye ulaşabilmeniz için gerekli kullanıcı doğrulamasının yapıldığı alandır.
let credential = Credential(username: "aahmetbas", password: "alp1234")

GetSettings.post(credential: credential) { (response) in
    if(response.status.code == 200){
        print("Main: \(response.settings.balance.main) Limit: \(response.settings.balance.limit)")
        print("Account: \(response.settings.operatorSettings.account) MSISDN: \(response.settings.operatorSettings.msisdn) ServiceId: \(response.settings.operatorSettings.serviceId) UnitPrice: \(response.settings.operatorSettings.unitPrice) VariantId: \(response.settings.operatorSettings.variantId)")

        for item in response.settings.senders {
            print("Value: \(item.value) Default: \(item.isDefault)")
        }
        
        for item in response.settings.keywords {
            print("Value: \(item.value) ServiceNumber: \(item.serviceNumber) Timestamp: \(item.timestamp) Validity: \(item.validity)")
        }
    }else{
        print("Code: \(response.status.code) Description: \(response.status.desc)")
    }
}

/////////////////////////////////////////
// gelen cevaplar ve anlamları.
/////////////////////////////////////////

// Status
// Code ve Desc alanları yer alır. Mesajın sisteme başarılı şekilde gönderilip gönderilmediği bilgisini verir.
// Code = 200 ve Description = OK ise mesaj sisteme başarılı şekilde ulaşmıştır. Bu mesajın iletim durumu değildir.
// Alabileceği değerler için dokümana bakınız.

// Balance
// Main:    Ana Kredi. Sahip olduğunuz kredi adetidir.
// Limit:   Eksiye düşebileceğiniz kredi adetidir.
// Kullanılabilir Kredi:    total = main + limit;

// Keyword
// ServiceNumber:   Servis numarası.
// Validity:        Geçerlilik süresi.
// Timestamp:       Zaman damgası.
// Value:           Servis numarasında kullanılacak SMS anahtar kelimesi.

// Sender
// Default:   Varsayılan başlık olup olmadığı bilgisidir. True (Evet) ve False (Hayır) değerleri alabilir.
// Value:     Gönderen başlığı.

// OperatorSettings
// Account:      Hesap tipiniz. Postpaid (Faturalı) ve Prepaid (Ön Ödemeli) değerleri alabilir.
// MSISDN:       Hesabınıza atanmış telefon varsa bu alanda gelir.
// ServiceId:    Servis numarası.
// UnitPrice:    Hesabınıza atanmış birim fiyat varsa bu alanda gelir.
// VariantId:    Varyant Id'si.
```
