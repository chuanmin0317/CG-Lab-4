### 1. Completed Tasks
- [x] Correctly implement the barycentric.
- [x] Correctly implement Phong Shading.
- [x] Correctly implement Flat Shading.
- [x] Correctly implement Gouraud Shading.
- [x] (Bonus) Successfully implement Texture Shading
### 3. How Tasks Were Completed
#### 1. Barycentric
- Implement the barycentric coordinates with perspective-correct interpolation.
  - [`util::barycentric()`](./util.pde)
### 2. Phong Shading
- Implement Phong shading in the shader.
  - [`Material::PhongMaterial`](./Material.pde)
  - [`ColorShader::PhongVertexShader`](./ColorShader.pde)
  - [`ColorShader::PhongFragmentShader`](./ColorShader.pde)

- 在 Fragment Shader 中進行光照計算。

- 傳遞了頂點法向量與位置至 Fragment Shader 進行插值。

- 實作了完整的 Phong Reflection Model (Ambient + Diffuse + Specular)。

https://github.com/user-attachments/assets/06a06640-00f4-45fe-a330-b47437ad3358


### 3. Flat Shading
- Implement Flat shading in the shader.
  - [`Material::FlatMaterial`](./Material.pde)
  - [`ColorShader::FlatVertexShader`](./ColorShader.pde)
  - [`ColorShader::FlatFragmentShader`](./ColorShader.pde)

- 在 `FlatMaterial` 中計算每一個三角形的 面法向量 (Face Normal) (利用 `Edge1` x `Edge2`)。

- 將計算出的單一面法向量賦予該三角形的三個頂點。

- 呈現出低多邊形 (Low-Poly) 的稜角風格。

https://github.com/user-attachments/assets/84c84613-e5a3-4108-a8cd-b10c23d55127


### 4. Gouraud Shading
- Implement Gouraud shading in the shader.
  - [`Material::GouraudMaterial`](./Material.pde)
  - [`ColorShader::GouraudVertexShader`](./ColorShader.pde)
  - [`ColorShader::GouraudFragmentShader`](./ColorShader.pde)

- 將光照計算移至 Vertex Shader 中執行。

- 在頂點階段計算出顏色後，將顏色作為 Varying 傳遞給 Fragment Shader 進行線性插值。

- 相比 Phong Shading 計算量較小，但在低面數模型上高光會較不精確。

https://github.com/user-attachments/assets/4ce4368c-3677-4f05-a43d-f26a3645e442


### Bonus: Texture Shading OR Something COOL AND GOOD
#### usage
1. 開啟 `HW4.pde`。
2. 在 `setup()` 函式中，去除下列程式碼前的註解

```Java
// GameObject model = new GameObject("data/Meshes/Elon_Musk_head.obj");
// model.material = new TextureMaterial("data/Textures/Elon_Musk_head.bmp");
    
// engine.renderer.addGameObject(model);
```
3. 執行程式(Run)
- 新增 `TextureMaterial` 類別，支援載入圖片 (PImage)。

- 在 Shader 中實作 UV 插值與紋理採樣 (Sampling)。

- 結合 Phong 光照模型，讓貼圖物體也能受光照影響（有陰影與反光）。

https://github.com/user-attachments/assets/5c05bcd0-cf39-4f43-8b51-546afae7e8c1


### 4. LLM usage
1.  請求協助完成 HW4 所需的演算法。
2.  對產生的bug進行分析並解決。
3.  針對實行CameraControl後所產生的NullPointer Error給出解決方案。
