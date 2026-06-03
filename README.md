# Sistem Rekap Nilai Praktikum Mahasiswa

## UTS Pemrograman Basis Data – Kelompok 04

---

## 👥 Anggota Kelompok

| No | Nama             | NIM   | Tanggung Jawab                                                         |
| -- | ---------------- | ----- | ---------------------------------------------------------------------- |
| 1  | [Nama Anggota 1] | [NIM] | Membuat database, tabel, relasi, dan data awal                         |
| 2  | [Nama Anggota 2] | [NIM] | Membuat perhitungan nilai akhir menggunakan variabel                   |
| 3  | [Nama Anggota 3] | [NIM] | Membuat percabangan grade, bobot, status kelulusan, dan perulangan     |
| 4  | [Nama Anggota 4] | [NIM] | Membuat implicit cursor, explicit cursor, dan cursor dengan parameter  |
| 5  | [Nama Anggota 5] | [NIM] | Membuat dokumentasi, laporan PDF, README GitHub, dan pengujian program |

---

## 📋 Deskripsi Sistem

Sistem Rekap Nilai Praktikum Mahasiswa merupakan sistem berbasis MySQL yang digunakan untuk mengelola data mahasiswa dan melakukan rekapitulasi nilai praktikum secara otomatis.

Fitur utama sistem:

* Menyimpan data mahasiswa, dosen, dan mata kuliah
* Menghitung nilai akhir mahasiswa secara otomatis
* Menentukan grade berdasarkan nilai akhir
* Menentukan bobot nilai
* Menentukan status kelulusan
* Menyimpan hasil rekap ke tabel log
* Mengimplementasikan implicit cursor, explicit cursor, dan cursor dengan parameter

---

## 🗄️ Struktur Database

Nama Database:

```text
uts_pbd_kelompok_04
```

Tabel yang digunakan:

```text
uts_pbd_kelompok_04
│
├── dosen
├── grade_nilai
├── log_rekap_nilai
├── mahasiswa
├── mata_kuliah
└── nilai_praktikum
```

### Keterangan Tabel

| Tabel           | Fungsi                            |
| --------------- | --------------------------------- |
| dosen           | Menyimpan data dosen pengampu     |
| mahasiswa       | Menyimpan data mahasiswa          |
| mata_kuliah     | Menyimpan data mata kuliah        |
| grade_nilai     | Menyimpan standar grade dan bobot |
| nilai_praktikum | Menyimpan data nilai mahasiswa    |
| log_rekap_nilai | Menyimpan hasil rekap nilai       |

---

## 📦 Stored Procedure

Sistem menggunakan beberapa Stored Procedure berikut:

| Procedure            | Fungsi                                   |
| -------------------- | ---------------------------------------- |
| hitung_nilai_akhir() | Menghitung nilai akhir mahasiswa         |
| tentukan_grade()     | Menentukan grade berdasarkan nilai akhir |
| tentukan_bobot()     | Menentukan bobot berdasarkan grade       |
| tentukan_status()    | Menentukan status kelulusan              |
| isi_log_nilai()      | Menyimpan hasil rekap ke tabel log       |
| tampil_nim_cursor()  | Implementasi explicit cursor             |
| rekap_nilai_per_mk() | Implementasi cursor dengan parameter     |

---

## 📐 Rumus Perhitungan Nilai Akhir

Rumus yang digunakan:

nilai_akhir = (nilai_tugas × 30%) + (nilai_kuis × 30%) + (nilai_uts × 40%)

---

## 📊 Ketentuan Grade dan Bobot

| Grade | Bobot | Rentang Nilai | Status      |
| ----- | ----- | ------------- | ----------- |
| A     | 4.00  | 93 – 100      | LULUS       |
| A-    | 3.75  | 85 – 92.99    | LULUS       |
| B+    | 3.50  | 81 – 84.99    | LULUS       |
| B     | 3.25  | 75 – 80.99    | LULUS       |
| B-    | 3.00  | 71 – 74.99    | LULUS       |
| C+    | 2.75  | 66 – 70.99    | LULUS       |
| C     | 2.50  | 61 – 65.99    | LULUS       |
| C-    | 2.00  | 56 – 60.99    | TIDAK LULUS |
| D     | 1.00  | 40 – 55.99    | TIDAK LULUS |
| E     | 0.00  | 0 – 39.99     | TIDAK LULUS |

---

## 🔧 Konsep Pemrograman Basis Data yang Digunakan

| Konsep                  | Implementasi                       |
| ----------------------- | ---------------------------------- |
| Variabel Lokal          | Perhitungan nilai akhir            |
| Percabangan (IF/CASE)   | Penentuan grade dan status         |
| Perulangan (LOOP)       | Pemrosesan data                    |
| Implicit Cursor         | ROW_COUNT()                        |
| Explicit Cursor         | DECLARE CURSOR, OPEN, FETCH, CLOSE |
| Cursor dengan Parameter | rekap_nilai_per_mk()               |
| Stored Procedure        | Otomatisasi proses rekap nilai     |

---

## ▶️ Cara Menjalankan Program

### Persyaratan

* XAMPP terinstal
* Apache dan MySQL aktif
* phpMyAdmin dapat diakses

### Langkah Menjalankan

1. Buka phpMyAdmin.
2. Buat database atau import file SQL.
3. Import file:

```text
uts_pbd_kelompok_04.sql
```

4. Jalankan seluruh Stored Procedure yang tersedia.
5. Lakukan pengujian menggunakan query SQL yang telah dibuat.

---

## 🧪 Pengujian Program

Pengujian dilakukan dengan:

1. Menghitung nilai akhir mahasiswa.
2. Menentukan grade mahasiswa.
3. Menentukan bobot nilai.
4. Menentukan status kelulusan.
5. Mengisi tabel log rekap nilai.
6. Menguji explicit cursor.
7. Menguji cursor dengan parameter.
8. Memastikan seluruh data berhasil diproses.

---

## 📂 Struktur Repository

```text
UTS_PBD_Kelompok_04/
├── uts_pbd_kelompok_04.sql
└── README.md
```

### Keterangan

* `uts_pbd_kelompok_04.sql` : Berisi database, tabel, data awal, dan stored procedure.
* `README.md` : Dokumentasi proyek.

---

## ✅ Kesimpulan

Sistem Rekap Nilai Praktikum Mahasiswa berhasil dibuat menggunakan MySQL dan Stored Procedure. Sistem mampu melakukan perhitungan nilai akhir, menentukan grade, bobot, status kelulusan, serta menerapkan implicit cursor, explicit cursor, dan cursor dengan parameter sesuai dengan kebutuhan tugas UTS Pemrograman Basis Data.

---

**Program Studi S1 Informatika**
**Universitas Mega Buana Palopo**
**2026**
