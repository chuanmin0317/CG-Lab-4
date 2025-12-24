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
![](./vidio/phong.mp4)
### 3. Flat Shading
- Implement Flat shading in the shader.
  - [`Material::FlatMaterial`](./Material.pde)
  - [`ColorShader::FlatVertexShader`](./ColorShader.pde)
  - [`ColorShader::FlatFragmentShader`](./ColorShader.pde)
### 4. Gouraud Shading
- Implement Gouraud shading in the shader.
  - [`Material::GouraudMaterial`](./Material.pde)
  - [`ColorShader::GouraudVertexShader`](./ColorShader.pde)
  - [`ColorShader::GouraudFragmentShader`](./ColorShader.pde)
### Bonus: Texture Shading OR Something COOL AND GOOD

### 4. LLM usage
1.  請求協助完成 HW4 所需的演算法。
2.  對產生的bug進行分析並解決。
3.  針對實行CameraControl後所產生的NullPointer Error給出解決方案。
