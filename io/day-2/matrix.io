Matrix := List clone
Matrix dim := method(x, y,  matrix := Matrix clone; for(i,1,y, row := list(); matrix append( for(j,1,x,row append(0)))))

Matrix dim(2,2) println

Matrix set := method(x,y,value, self at(x) atPut(y,value); self)
Matrix get := method(x,y, self at(x) at(y))

Matrix dim(2,2) set(1,1,"something") println
Matrix dim(2,2) set(1,1,"something") get(1,1) println

Matrix transpose := method(n_m := Matrix dim(self size, self at(0) size); self foreach(c, column, column foreach(r, e, n_m set(r,c,e)));n_m)

m := Matrix dim(2,2) set(0,0, "0 0") set(0,1, "0 1") set(1,0, "1 0") set(1,1, "1 1")
m println
m transpose println

File with("matrix.txt") openForUpdating write(m serialized) close
doFile("matrix.txt") println

