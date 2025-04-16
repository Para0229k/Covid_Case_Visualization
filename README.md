# Covid-19 Case Statistic App (MATLAB App Designer)

用MATLAB App Designer將Covid-19的全球統計資料進行視覺化  
使用MATLAB Online製作  

![image](https://github.com/user-attachments/assets/1f9cc74a-729f-4279-815b-a299dd7c298f)

---

## 檔案結構

| 檔案 | 說明 |
|------|-------------|
| `Covid_Case_Statistic.mlapp` | MATLAB App Designer主程式 |
| `Covid DATA.mat` | COVID-19統計資料 |
| `Covid_Case_Statistic_Code.m` | 展示程式碼用的.m檔案 |

---

## 介面說明

![044412F5-5AC0-4D5F-A2F8-729E6C33913A](https://github.com/user-attachments/assets/2a26109f-e80f-40ec-a119-151bd194c29e)

- **Graph**：根據其他選項改變繪製資料、標題、繪製方式
- **Country**：選擇繪製不同國家的資料，預設為Global
- **State of Region**：若選擇的國家有提供地區資料則顯示選項，選擇後只顯示該地區的資料，預設為All
- **Averaged # of days**：改變滑動平均的取樣數，取樣方式為自己+前N-1天，預設為1(不平均)
- **Data to Plot**：選擇要顯示的資料，預設為Cases
- **Option**：選擇資料顯示的形式，預設為Cumulative

---

## 資料說明

![image](https://github.com/user-attachments/assets/f16e4f7c-05d2-4ddf-a26a-8b35fe77f7d5)

資料來源：https://coronavirus.jhu.edu/map.tml  
來自Johns Hopkins University的Coronavirus Resource Center  

該檔案是一個大型cell array，包含按照國家(第一行)、地區(第二行)、日期(第一列)區分的病例(第一個元素)和死亡人數(第二個元素)

---

## 未來延伸方向

- **Search**：讓使用者直接搜尋國家
- **Save**：儲存圖片
- **Start & Stop**：讓使用者選取X顯示範圍
