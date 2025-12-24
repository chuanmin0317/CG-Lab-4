public void CGLine(float x1, float y1, float x2, float y2) {
    stroke(0);
    line(x1, y1, x2, y2);
}

public boolean outOfBoundary(float x, float y) {
    if (x < 0 || x >= width || y < 0 || y >= height)
        return true;
    return false;
}

public void drawPoint(float x, float y, color c) {
    int index = (int) y * width + (int) x;
    if (outOfBoundary(x, y))
        return;
    pixels[index] = c;
}

public float distance(Vector3 a, Vector3 b) {
    Vector3 c = a.sub(b);
    return sqrt(Vector3.dot(c, c));
}

boolean pnpoly(float x, float y, Vector3[] vertexes) {
    // TODO HW2
    // You need to check the coordinate p(x,v) if inside the vertexes. 

    int i, j;
    boolean c = false;
    for (i = 0, j = vertexes.length - 1; i < vertexes.length; j = i++) {
        Vector3 vi = vertexes[i];
        Vector3 vj = vertexes[j];
        if (((vi.y > y) != (vj.y > y)) &&
            (x < (vj.x - vi.x) * (y - vi.y) / (vj.y - vi.y) + vi.x)) {
            c = !c;
        }
    }
    return c;
}

public Vector3[] findBoundBox(Vector3[] v) {
    // Vector3 recordminV = new Vector3(1.0 / 0.0);
    // Vector3 recordmaxV = new Vector3(-1.0 / 0.0);
    // TODO HW2
    // You need to find the bounding box of the vertexes v.

    if (v.length == 0) {
        Vector3[] result = { new Vector3(0), new Vector3(0) };
        return result;
    }
    
    float minX = v[0].x;
    float minY = v[0].y;
    float maxX = v[0].x;
    float maxY = v[0].y;
    
    for (int i = 1; i < v.length; i++) {
        minX = min(minX, v[i].x);
        minY = min(minY, v[i].y);
        maxX = max(maxX, v[i].x);
        maxY = max(maxY, v[i].y);
    }

    Vector3 recordminV = new Vector3(minX, minY, 0);
    Vector3 recordmaxV = new Vector3(maxX, maxY, 0);
    Vector3[] result = { recordminV, recordmaxV };
    return result;
}

Vector3 getInterrsection(Vector3 p1, Vector3 p2, float clipV, boolean isX){
    float t = 0.0f;
    Vector3 P_diff = p2.sub(p1);
    if (isX){
        float dx = P_diff.x;
        if (abs(dx) < 1e-6) return p1.copy();
        t = (clipV - p1.x) / dx;
    }else{
        float dy = P_diff.y;
        if (abs(dy) < 1e-6) return p1.copy();
        t = (clipV - p1.y) / dy;
    }

    return p1.add(P_diff.mult(t));
}

public Vector3[] Sutherland_Hodgman_algorithm(Vector3[] points, Vector3[] boundary) {
    ArrayList<Vector3> input = new ArrayList<Vector3>();
    ArrayList<Vector3> output = new ArrayList<Vector3>();
    for (int i = 0; i < points.length; i += 1) {
        input.add(points[i]);
    }

    // TODO HW2
    // You need to implement the Sutherland Hodgman Algorithm in this section.
    // The function you pass 2 parameter. One is the vertexes of the shape "points".
    // And the other is the vertexes of the "boundary".
    // The output is the vertexes of the polygon.

    output = input;

    for (int i = 0; i < 4; i++){
        ArrayList<Vector3> newOutput = new ArrayList<Vector3>();
        if (output.size() == 0) break;

        float clipVal;
        boolean isXClip;
        boolean isGreaterSide;

        if (i == 0){
            clipVal = -1.0f;
            isXClip = true;
            isGreaterSide = true;
        } else if (i == 1){
            clipVal = 1.0f;
            isXClip = false;
            isGreaterSide = false;
        } else if (i == 2){
            clipVal = 1.0f;
            isXClip = true;
            isGreaterSide = false;
        } else {
            clipVal = -1.0f;
            isXClip = false;
            isGreaterSide = true;
        }
    

        for (int j = 0; j < output.size(); j++){
            Vector3 P_curr = output.get(j);
            Vector3 P_prev = output.get((j + output.size() - 1) % output.size());

            boolean inside_curr;
            if (isXClip){
                inside_curr = isGreaterSide ? (P_curr.x >= clipVal) : (P_curr.x <= clipVal);
            }else{
                inside_curr = isGreaterSide ? (P_curr.y >= clipVal) : (P_curr.y <= clipVal);
            }

            boolean inside_prev;
            if (isXClip){
                inside_prev = isGreaterSide ? (P_prev.x >= clipVal) : (P_prev.x <= clipVal);
            }else{
                inside_prev = isGreaterSide ? (P_prev.y >= clipVal) : (P_prev.y <= clipVal);
            }

            if (inside_curr){
                if (!inside_prev){
                    newOutput.add(getInterrsection(P_prev, P_curr, clipVal, isXClip));
                }
                newOutput.add(P_curr);
            }else if (inside_prev){
                newOutput.add(getInterrsection(P_prev, P_curr, clipVal, isXClip));
            }
        }
        output = newOutput;
    }

    Vector3[] result = new Vector3[output.size()];
    for (int i = 0; i < result.length; i += 1) {
        result[i] = output.get(i);
    }
    return result;
}

public float getDepth(float x, float y, Vector3[] vertex) {
    // TODO HW3
    // You need to calculate the depth (z) in the triangle (vertex) based on the
    // positions x and y. and return the z value;

    Vector3 v0 = vertex[0];
    Vector3 v1 = vertex[1];
    Vector3 v2 = vertex[2];

    Vector3 v01 = v1.sub(v0);
    Vector3 v02 = v2.sub(v0);

    Vector3 n = Vector3.cross(v01, v02);


    if (n.z == 0) return v0.z; 

    float z = v0.z - (n.x * (x - v0.x) + n.y * (y - v0.y)) / n.z;

    return z;
}

float[] barycentric(Vector3 P, Vector4[] verts) {

    Vector3 A = verts[0].homogenized();
    Vector3 B = verts[1].homogenized();
    Vector3 C = verts[2].homogenized();

    Vector4 AW = verts[0];
    Vector4 BW = verts[1];
    Vector4 CW = verts[2];

    // TODO HW4
    // Calculate the barycentric coordinates of point P in the triangle verts using
    // the barycentric coordinate system.
    // Please notice that you should use Perspective-Correct Interpolation otherwise
    // you will get wrong answer.

    float denominator = (B.y - C.y) * (A.x - C.x) + (C.x - B.x) * (A.y - C.y);
    
    if (denominator == 0) return new float[]{0, 0, 0};

    float alpha = ((B.y - C.y) * (P.x - C.x) + (C.x - B.x) * (P.y - C.y)) / denominator;
    
    float beta = ((C.y - A.y) * (P.x - C.x) + (A.x - C.x) * (P.y - C.y)) / denominator;
    
    float gamma = 1.0f - alpha - beta;

    float wA = 1.0f / AW.w;
    float wB = 1.0f / BW.w;
    float wC = 1.0f / CW.w;

    float recipW = alpha * wA + beta * wB + gamma * wC;

    alpha = (alpha * wA) / recipW;
    beta  = (beta * wB) / recipW;
    gamma = (gamma * wC) / recipW;

    return new float[] { alpha, beta, gamma };
}

Vector3 interpolation(float[] abg, Vector3[] v) {
    return v[0].mult(abg[0]).add(v[1].mult(abg[1])).add(v[2].mult(abg[2]));
}

Vector4 interpolation(float[] abg, Vector4[] v) {
    return v[0].mult(abg[0]).add(v[1].mult(abg[1])).add(v[2].mult(abg[2]));
}

float interpolation(float[] abg, float[] v) {
    return v[0] * abg[0] + v[1] * abg[1] + v[2] * abg[2];
}
