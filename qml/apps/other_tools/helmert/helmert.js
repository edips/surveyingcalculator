function myparser(inp){
    return parseFloat(inp.text.replace(',','.').replace(' ',''))
}
//----------HELMERT 2D TRANSFORMATION CALC------------------------------------------------
function helmertcalc(){
    // text input parameters
    var xa  = myparser( pt_a.north )
    var ya  = myparser( pt_a.east )
    var xb  = myparser( pt_b.north )
    var yb  = myparser( pt_b.east )
    var xau = myparser( pt_au.north )
    var yau = myparser( pt_au.east )
    var xbu = myparser( pt_bu.north )
    var ybu = myparser( pt_bu.east )
    var xpu = myparser( pt_pu.north )
    var ypu = myparser( pt_bu.east )
    // end
    var dx = xb-xa
    var dy = yb-ya
    var dxu = xbu-xau
    var dyu = ybu-yau
    var su = Math.sqrt(dxu*dxu + dyu*dyu)
    var aa = (dy*dxu - dx*dyu)/(su*su)
    var bb = (dx*dxu + dy*dyu)/(su*su)
    var x0u = xa - xau*bb + yau*aa
    var y0u = ya - xau*aa - yau*bb
    var xp = x0u + xpu*bb - ypu*aa
    var yp = y0u + xpu*aa + ypu*bb
    if(
            pt_a.north.text === "" ||
            pt_a.east.text === "" ||
            pt_b.north.text === "" ||
            pt_b.east.text === "" ||
            pt_au.north.text === "" ||
            pt_au.east.text === "" ||
            pt_bu.north.text === "" ||
            pt_bu.east.text === "" ||
            pt_pu.north.text === "" ||
            pt_pu.east.text === ""
       )
        {
        snack.open(qsTr("Please enter the values."))
        }
    else{
        np.text=xp.toFixed(3)
        ep.text=yp.toFixed(3)
    }
}
