# COVID-19 Case Visualization App（OOP Version）

用MATLAB製作的COVID-19疫情資料視覺化應用  
以App Designer建立互動式圖形介面，使用物件導向架構（OOP）設計資料結構  
> 使用MATLAB online製作，資料來源為Johns Hopkins University Coronavirus Resource Center  

![image](https://github.com/user-attachments/assets/1f9cc74a-729f-4279-815b-a299dd7c298f)

> 目錄  
> [1. 檔案結構](#1-檔案結構)  
> [2. 使用說明](#2-使用說明)  
> [3. 主要功能](#3-主要功能)  
> [4. 未來延伸方向](#4-未來延伸方向)  
> [5. 參考資料](#5-參考資料)  
> [6. 版本紀錄](#6-版本紀錄)  
> [7. 執行圖片](#7-執行圖片)  

---

## 1. 檔案結構

```bash
Covid_Case_Visualization/
├── Covid DATA.mat                    # 原始疫情統計資料（每日確診、死亡數）
├── Covid_Case_Statistic.mlapp        # 主程式介面與事件控制（MATLAB App）
├── Covid_Case_Statistic_code.m       # 為Github展示.mlapp中程式碼之對應版本
└── Global_data.m                     # 定義OOP架構：Global > Country > Region

```
> [點此下載完整專案檔案](https://drive.google.com/drive/folders/1s-ahcmWuNj28gGe-XnjFN7_mTLU6lVp7?usp=sharing)

---

## 2. 使用說明

1. 開啟 `Covid_Case_Statistic.mlapp`（用MATLAB App Designer）
2. 執行並進入App介面
3. 從下拉選單選擇國家 / 地區
4. 選擇每日統計或累積統計、確診或死亡
5. 點擊切換顯示移動平均曲線或雙座標軸圖表

---

## 3. 主要功能

|   功能類型    |                  說明                     |
|-----------|--------------------------------------------|
|**國家/地區切換**|使用下拉選單切換不同區域的疫情資料              |
|**統計類型切換**|選擇每日新增或累積數據顯示（Case / Death / Both）|
|**移動平均顯示**|顯示指定天數的移動平均線，平滑資料變化趨勢        |
|**雙軸圖表支援**|同時顯示確診與死亡數據，以不同y軸呈現             |
|**動態標題**    |根據使用者選擇自動調整圖表標題與顯示樣式          |
|**物件導向設計**|使用 Global > Country > Region 結構封裝資料     |

### 介面說明

![044412F5-5AC0-4D5F-A2F8-729E6C33913A](https://github.com/user-attachments/assets/2a26109f-e80f-40ec-a119-151bd194c29e)

|區塊|說明|
|----------------------|------------------------------------|
|**Graph**             |根據其他選項改變繪製資料、標題、繪製方式|
|**Country**           |選擇繪製不同國家的資料，預設為Global|
|**State of Region**   |若選擇的國家有提供地區資料則顯示選項，選擇後只顯示該地區的資料，預設為All|
|**Averaged # of days**|改變滑動平均的取樣數，取樣方式為自己+前N-1天，預設為1(不平均)|
|**Data to Plot**      |選擇要顯示的資料，預設為Cases|
|**Option**            |選擇資料顯示的形式，預設為Cumulative|

---

## 4. 未來延伸方向

|延伸項目|說明|
|----------| ------------------------ |
|**搜尋功能**            | 讓使用者直接搜尋國家           |
|**地圖顯示功能**         | 加入地圖式呈現地區疫情熱度            |
|**匯出功能**            | 匯出圖表為 PNG / PDF |
|**Start & Stop**       | 讓使用者選取X顯示範圍         |
|**單一地區長期觀測模式**| 支援時間軸回放、長期趨勢分析           |

---

## 5. 參考資料

[Johns Hopkins University CSSE COVID-19 Dataset](https://coronavirus.jhu.edu/map.html)  

[Multimedia Information Retrieval LAB](http://mirlab.org/jang/books/matlabprogramming4beginner/03-1_basicPlotXY.asp?title=3-1%20%B0%F2%A5%BB%AA%BA%A4G%BA%FB%C3%B8%B9%CF%AB%FC%A5O)  

[Plot Dates and Times - MATLAB \&amp; Simulink](https://ww2.mathworks.cn/help/matlab/matlab_prog/plot-dates-and-times.html)  

### 使用資料說明

![image](https://github.com/user-attachments/assets/f16e4f7c-05d2-4ddf-a26a-8b35fe77f7d5)

來自Johns Hopkins University的Coronavirus Resource Center  

該檔案是一個大型cell array，包含按照國家(第一行)、地區(第二行)、日期(第一列)區分的病例(第一個元素)和死亡人數(第二個元素)

---

## 6. 版本紀錄

|版本|說明|
|----|-------------------------- |
|v1.0|初版發布，使用cell array與陣列繪製資料|
|v2.0|完成移動平均拉桿、資料選取按鈕、繪製方式按鈕、動態標題、雙座標軸|
|v2.1|整合 OOP 與 GUI，重構資料呼叫邏輯|

---

## 7. 執行圖片

### ▸ Cumulative Global Cases
![image](https://github.com/user-attachments/assets/49cf0d73-4135-401f-877a-ff751cb0fe4e)

### ▸ Daily UK Deathes
![image](https://github.com/user-attachments/assets/f55bb472-8856-4948-bebb-41ba5846ca44)

### ▸ Daily UK Deathes (10 day mean)
![image](https://github.com/user-attachments/assets/be0d1f25-d437-46f3-a397-5865fb6a3412)

### ▸ Daily France Deathes & Cases (15 day mean)
![image](https://github.com/user-attachments/assets/da079bd4-4ca0-46a2-922b-ae4765a0e77b)



