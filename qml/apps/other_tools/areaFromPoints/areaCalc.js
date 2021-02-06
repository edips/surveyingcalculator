var coord_list = [];

var area_metric = "";

var perimeter_metric = 0;

// Calculate area from coordinates
function calculate_area( coords ) {
    var t = 0;
    for( var i = 0; i < ( coords.length - 1 ); i++ ) {
        var y = coords[ i + 1 ][1] + coords[i][1];
        var x = coords[ i + 1 ][0] - coords[i][0];
        var z = y * x;
        t = t + z;
    }
    return Math.abs( t / 2.0 );
}

// Another method to calculate area
// Display the area
/*
function getArea( coord_list ) {
    // Shoelace algorithm
    // Ref: https://en.wikipedia.org/wiki/Shoelace_formula
    var sum = 0;
    for(var i = 0; i < coord_list.length; i++) {
        var point = coord_list[ i ];
        var nextPoint = i + 1 !== coord_list.length ? coord_list[ i + 1 ] : coord_list[ 0 ];
        sum += ( point[0] * nextPoint[1] ) - ( nextPoint[0] * point[1] );
    }
    return Math.abs(sum) / 2;
}
*/

function result() {
    var coord_txt = ( editor.text ).match(/[^\r\n]+/g);
    if( editor.text === "" )
    {
        snack.open( qsTr( "Please enter the coordinates." ) );
    }
    else if( coord_txt.length < 3 ) {
        snack.open( qsTr( "Enter minimum 3 coordinates for area calculation." ) );
    }
    else {
        coord_list = coord_txt.map( function( e ) {
            // trims spaces out of the coordinate pairs
            e = e.trim();
            return e.split(/(?:,| )+/).map( Number );
        })
        coord_list.push( coord_list[0] );

        for ( var t=0; t < coord_list.length; t++ ) {
            if ( coord_list[t].length !== 2 ) {
                snack.open( qsTr("Please check the coordinates. See the help page for more information." ) );
                break;
            }
        }

        // calculate area in metric
        area_metric = calculate_area( coord_list )
        // convert units
        areaByUnits()

        // Display area shape
        display_area( coord_list, canvas, area.text );
        canvas.requestPaint();

        // Calculate perimeter
        perimByUnits();
    }
}

// Calculate perimeter with units
function perimByUnits() {
    // meter
    if ( perim_combo.currentIndex === 0 ) {
        perimeter.text = perimeter_metric.toFixed(2);
    }
    // km
    else if( perim_combo.currentIndex === 1 ) {
        perimeter.text = ( perimeter_metric * 0.001 ).toFixed(2);
    }
    // mi
    else if( perim_combo.currentIndex === 2 ) {
        perimeter.text = ( perimeter_metric * 0.0006213712 ).toFixed(2);
    }
    // yard
    else if( perim_combo.currentIndex === 3 ) {
        perimeter.text = (perimeter_metric * 1.0936132983 ).toFixed(2);
    }
    // feet
    else if( perim_combo.currentIndex === 4 ) {
        perimeter.text = ( perimeter_metric * 3.280839895 ).toFixed(2);
    }
}

// Calculate area with units
function areaByUnits() {
    // m2
    if ( areacombo.currentIndex === 0 ) {
        area.text = area_metric.toFixed( 2 );
    }
    // km2
    else if( areacombo.currentIndex === 1 ) {
        area.text = ( area_metric * 0.000001 ).toFixed( 2 );
    }
    // ha
    else if( areacombo.currentIndex === 2 ) {
        area.text = ( area_metric * 0.0001).toFixed( 2 );
    }
    // acre
    else if( areacombo.currentIndex === 3 ) {
        area.text = ( area_metric * 0.000247105381467165 ).toFixed( 2 );
    }
    // mile
    else if( areacombo.currentIndex === 4 ) {
        area.text = ( area_metric * 0.000000386102158542446).toFixed( 2 );
    }
    // yard
    else if( areacombo.currentIndex === 5 ) {
        area.text = ( area_metric * 1.19599004630108 ).toFixed( 2 );
    }
    // feet
    else if( areacombo.currentIndex === 6 ) {
        area.text = ( area_metric * 10.7639104167097 ).toFixed( 2 );
    }
}

// Display shape of the area
function display_area( coord_list, canvas, area_txt ) {
    var ctx = canvas.getContext( "2d" );
    ctx.reset();
    ctx.fillStyle = "#F5F5F5";
    ctx.fillRect( 0, 0, width, height );
    ctx.lineWidth = 2;
    ctx.textAlign = "center";

    // Do not paint if there isn't enough points to create a line
    if( coord_list.length < 2 ) {
        return;
    }

    perimeter_metric = 0;
    // Draw the polygon
    for( var i = 1; i < coord_list.length; i++ ) {
        // Create line with 2 points
        var previousPoint = set_scale( coord_list[ i - 1 ], coord_list );

        //var point = coord_list[ i ]
        var point = set_scale( coord_list[ i ], coord_list );

        var orj_point = coord_list[ i ];
        var orj_prev_point = coord_list[ i - 1 ];

        if( i + 1 < coord_list.length ) {
            var nextPoint = set_scale( coord_list[ i + 1 ], coord_list );
            //draw( previousPoint, point, nextPoint )
        }
        // Calculate line middle point
        var middlePoint = [ ( point[0] + previousPoint[0] ) / 2, ( point[1] + previousPoint[1] ) / 2 ];
        // Translated line to the origin
        var dist_angle = [ point[0] - previousPoint[0], point[1] - previousPoint[1] ];
        var translatedLine = [ orj_point[0] - orj_prev_point[0], orj_point[1] - orj_prev_point[1] ];
        // Calculate relative distance between the line points
        var relativeDistance = Math.hypot( translatedLine[1], translatedLine[0] );
        perimeter_metric += relativeDistance;
        // Calculate line angle
        var angle = Math.atan( dist_angle[1] / dist_angle[0] );
        // Translate and rotate ctx to draw distance text
        ctx.save();
        if( dist_menu.checked ) {
            ctx.translate( middlePoint[0], middlePoint[1] );
            ctx.rotate( angle );
            ctx.font='12px "Lato"';
            ctx.fillStyle = "black";
            ctx.textBaseline = "middle";
            ctx.fillText( lengthUnits( relativeDistance ), 0, -5 );
        }
        // Restore from translation and rotation
        ctx.restore();

        // Draw line to the next point
        ctx.lineTo( point[0] , point[1] );
    }

    // If there is enough points to create a polygon, fill it and add area information
    if( coord_list.length > 2 ) {
        var centerPoint = getCentroid( coord_list );
        ctx.font='bold 16px "Lato"';
        ctx.fillStyle = "black";
        ctx.textBaseline = "middle";
        ctx.fillText( area_txt + " " + areacombo.currentText, centerPoint[0], centerPoint[1] );
        ctx.fillStyle = "rgba(255, 222, 0, 0.1)";
        ctx.closePath();
        ctx.fill();
    }

    ctx.stroke();

    // Point name
    if( point_menu.checked ) {
        displayPointName( coord_list, ctx );
    }

    // draw angle
    for( var k = 0; k < coord_list.length - 1; k++ ) {

        let previousPoint2 = [];
        let nextPoint2 = [];

        if( k - 1 < 0 ) {
            previousPoint2 = set_scale( coord_list[ coord_list.length - 2 ], coord_list );
        } else {
            previousPoint2 = set_scale( coord_list[ k - 1 ], coord_list );
        }

        if( k + 1 >= coord_list.length - 1 ) {
            nextPoint2 = set_scale( coord_list[ 0 ], coord_list );
        } else {
            nextPoint2 = set_scale( coord_list[ k + 1 ], coord_list );
        }

        var point2 = set_scale( coord_list[ k ], coord_list );

        createPath( coord_list, ctx )
        if( angle_menu.checked ) {
            display_angle( previousPoint2, point2, nextPoint2, ctx );
        }
        ctx.stroke();
    }
}

// Point name
function displayPointName( coord_list, ctx ) {
    var count = 1;
    for( let i = 0; i < coord_list.length-1; i++ ) {
        // points
        let point = set_scale( coord_list[ i ], coord_list );
        let prev_point = [];
        let next_point = [];

        if( i - 1 < 0 ) {
            prev_point = set_scale( coord_list[ coord_list.length - 2 ], coord_list );
        } else {
            prev_point = set_scale( coord_list[ i - 1 ], coord_list );
        }

        // fixed..
        if( i + 1 >= coord_list.length ) {
            next_point = set_scale( coord_list[ i ], coord_list );
        } else {
            next_point = set_scale( coord_list[ i + 1 ], coord_list );
        }

        // axis distance between points
        var dx1 = prev_point[0] - point[0];
        var dy1 = prev_point[1] - point[1];
        var dx2 = next_point[0] - point[0];
        var dy2 = next_point[1] - point[1];

        // line direction parameter to find angle
        var ax1 = Math.atan2(dy1, dx1);
        var ax2 = Math.atan2(dy2, dx2);

        // use cross product to find correct direction.
        if( dx1 * dy2 - dy1 * dx2 < 0 ) { // wrong way around swap direction
            const t = ax2;
            ax2 = ax1;
            ax1 = t;
        }
        // if angle 1 is behind then move ahead
        if( ax1 < ax2 ){
            ax1 += Math.PI * 2;
        }

        // getting angle
        createPath( coord_list, ctx );
        var angle = get_angle( ax1, ax2, point, ctx );

        // if the angle is wide, point number is inside of the polygon. To prevent this, we use this logic
        var mx;
        var my;
        if( isWideAngle( angle ) ) {
            mx = -Math.cos( (ax1 + ax2) / 2) * 15 + point[0];
            my = -Math.sin( (ax1 + ax2) / 2) * 15 + point[1];
        } else {
            mx = Math.cos( (ax1 + ax2) / 2) * 15 + point[0];
            my = Math.sin( (ax1 + ax2) / 2) * 15 + point[1];
        }

        // point number text
        ctx.font='bold 13px "Lato"';
        ctx.fillStyle = "#e60000";
        ctx.textBaseline = "middle";
        ctx.fillText( count, mx, my );

        // Point symbol
        ctx.beginPath();
        ctx.arc( point[0], point[1], 2, 0, 2 * Math.PI );
        ctx.stroke();
        count++;
    }
}

// is greater than 180 or 200
function isWideAngle( angle ) {
    if( __appSettings.angleUnit === 0 || __appSettings.angleUnit === 1 ) {
        return angle >= 180;
    } else {
        return angle >= 200;
    }
}

// Get angle from points
function get_angle( ax1, ax2, point, ctx ) {
    var grad = parseInt((ax2 - ax1) * 200 / Math.PI + 400) % 400;
    var degree = parseInt((ax2 - ax1) * 180 / Math.PI + 360) % 360;
    var a;
    if( __appSettings.angleUnit === 0 || __appSettings.angleUnit === 1 ) {
        a = degree;
    } else {
        a = grad;
    }
    // detect if arc is inside or outside polygon:
    var aa = ax1 + 0.22;
    var x = point[0] + 5 * Math.cos( aa );
    var y = point[1] + 5 * Math.sin( aa );
    var isInside = ctx.isPointInPath( x, y );
    var angle = (isInside ? a : (__appSettings.angleUnit === 0 || __appSettings.angleUnit === 1 ? (360 - a) : (400 - a) ) );
    return angle;
}

// Necessary to know if the object in the closed shape or not
function createPath(  coord_list, ctx  ) {
    ctx.beginPath();
    for( var i = 0; i < coord_list.length; i++ ) {
        var point = set_scale( coord_list[ i ], coord_list );
        // Draw line to the next point
        ctx.lineTo( point[0] , point[1] );
    }
    ctx.closePath();
}

// Draw angle
function display_angle( p1, p2, p3, ctx ) {
    // difference between coordinates
    var dx1 = p1[0] - p2[0];
    var dy1 = p1[1] - p2[1];
    var dx2 = p3[0] - p2[0];
    var dy2 = p3[1] - p2[1];

    // line direction parameter to find angle
    var ax1 = Math.atan2( dy1, dx1 );
    var ax2 = Math.atan2( dy2, dx2 );
    // use cross product to find correct direction.
    if( dx1 * dy2 - dy1 * dx2 < 0 ) { // wrong way around swap direction
        const t = ax2;
        ax2 = ax1;
        ax1 = t;
    }
    // if angle 1 is behind then move ahead
    if( ax1 < ax2 ) {
        ax1 += Math.PI * 2;
    }

    /// detect if arc is inside or outside polygon:
    var aa = ax1 + 0.22;
    var x = p2[0] + 5 * Math.cos( aa );
    var y = p2[1] + 5 * Math.sin( aa );
    var isInside = ctx.isPointInPath( x, y );

    ctx.font='italic 12px "Lato"'
    ctx.save();
    ctx.beginPath();
    ctx.moveTo( p2[0], p2[1] );
    ctx.arc( p2[0], p2[1], 10, ax1, ax2, !isInside );
    ctx.strokeStyle = "rgba(255, 141, 45, 0.3)";
    ctx.stroke();
    ctx.closePath();

    var angle = get_angle( ax1, ax2, p2, ctx )

    // if the angle is wide, angle text is inside of the polygon. To prevent this, we use this logic
    var mx;
    var my;
    if( isWideAngle( angle ) ) {
        mx = Math.cos( ( ax1 + ax2 ) / 2 ) * 25 + p2[0];
        my = Math.sin( ( ax1 + ax2 ) / 2 ) * 25 + p2[1];
    } else {
        mx = -Math.cos( ( ax1 + ax2 ) / 2 ) * 25 + p2[0];
        my = -Math.sin( ( ax1 + ax2 ) / 2 ) * 25 + p2[1];
    }

    ctx.fillStyle = "blue";
    ctx.fillText( angle, mx, my );
    ctx.stroke();
}

// Set scale from local coordinate to canvas extent
function set_scale( mylist, coord_list ) {
    var x = mylist[0];
    var y = mylist[1];

    // Get the extent of the geometry
    var minX, minY, maxX, maxY;
    coord_list.forEach( ( p, i ) => {
                           if( i === 0 ) { // if first point
                               minX = maxX = p[0];
                               minY = maxY = p[1];
                           } else {
                               minX = Math.min(p[0], minX );
                               minY = Math.min(p[1], minY );
                               maxX = Math.max(p[0], maxX );
                               maxY = Math.max(p[1], maxY );
                           }
                       } );
    // now get the map width and heigth in its local coords
    const mapWidth = maxX - minX;
    const mapHeight = maxY - minY;

    const mapCenterX = ( maxX + minX ) / 2;
    const mapCenterY = ( maxY + minY ) / 2;

    // to find the scale that will fit the canvas get the min scale to fit height or width
    const scale = Math.min( ( ( canvas.width - 55 ) / mapWidth ), ( ( canvas.height - 55 ) / mapHeight ) );

    x = ( x - mapCenterX ) * scale + canvas.width / 2;
    y = canvas.height - ( ( y - mapCenterY ) * scale + canvas.height / 2 );
    return [x, y];
}

function set_scale( mylist, coord_list ) {
    if( __appSettings.xyOrder === "en" ) {
        return set_scale_xy( mylist, coord_list );
    } else {
        return set_scale_yx( mylist, coord_list );
    }
}

// Set scale from local coordinate to canvas extent
function set_scale_xy( mylist, coord_list ) {
    var x = mylist[0];
    var y = mylist[1];

    // Get the extent of the geometry
    var minX, minY, maxX, maxY;
    coord_list.forEach( ( p, i ) => {
                           if( i === 0 ) { // if first point
                               minX = maxX = p[0];
                               minY = maxY = p[1];
                           } else {
                               minX = Math.min(p[0], minX );
                               minY = Math.min(p[1], minY );
                               maxX = Math.max(p[0], maxX );
                               maxY = Math.max(p[1], maxY );
                           }
                       } );
    // now get the map width and heigth in its local coords
    const mapWidth = maxX - minX;
    const mapHeight = maxY - minY;

    const mapCenterX = ( maxX + minX ) / 2;
    const mapCenterY = ( maxY + minY ) / 2;

    // to find the scale that will fit the canvas get the min scale to fit height or width
    const scale = Math.min( ( ( canvas.width - 55 ) / mapWidth ), ( ( canvas.height - 55 ) / mapHeight ) );

    x = ( x - mapCenterX ) * scale + canvas.width / 2;
    y = canvas.height - ( ( y - mapCenterY ) * scale + canvas.height / 2 );
    return [x, y];
}

// Set scale from local coordinate to canvas extent
function set_scale_yx( mylist, coord_list ) {
    var x = mylist[1];
    var y = mylist[0];

    // Get the extent of the geometry
    var minX, minY, maxX, maxY;
    coord_list.forEach( ( p, i ) => {
                           if( i === 0 ) { // if first point
                               minX = maxX = p[1];
                               minY = maxY = p[0];
                           } else {
                               minX = Math.min(p[1], minX );
                               minY = Math.min(p[0], minY );
                               maxX = Math.max(p[1], maxX );
                               maxY = Math.max(p[0], maxY );
                           }
                       } );
    // now get the map width and heigth in its local coords
    const mapWidth = maxX - minX;
    const mapHeight = maxY - minY;

    const mapCenterX = ( maxX + minX ) / 2;
    const mapCenterY = ( maxY + minY ) / 2;

    // to find the scale that will fit the canvas get the min scale to fit height or width
    const scale = Math.min( ( ( canvas.width - 55 ) / mapWidth ), ( ( canvas.height - 55 ) / mapHeight ) );

    x = ( x - mapCenterX ) * scale + canvas.width / 2;
    y = canvas.height - ( ( y - mapCenterY ) * scale + canvas.height / 2 );
    return [x, y];
}

// Get centroid of the area
function getCentroid( coord_list ) {
    // Calculate the centroid of a non-self-intersecting closed polygon defined by n vertices
    // Ref: https://en.wikipedia.org/wiki/Centroid
    var areaMultiplied = 6 * area_metric;

    var centroid = [ 0, 0 ];
    for( var i = 0; i < coord_list.length; i++ ) {
        var point = coord_list[ i ];
        var nextPoint = i + 1 !== coord_list.length ? coord_list[ i + 1 ] : coord_list[ 0 ];
        var multiplier = ( point[0] * nextPoint[1] ) - ( nextPoint[0] * point[1] );
        centroid[0] += ( point[0] + nextPoint[0] ) * multiplier;
        centroid[1] += ( point[1] + nextPoint[1] ) * multiplier;
    }
    var cent_x = Math.abs( centroid[0] / areaMultiplied );
    var cent_y = Math.abs( centroid[1] / areaMultiplied );
    return set_scale( [ cent_x, cent_y ], coord_list );
}

// length unit conversion from meters to other units
function lengthUnits( length_metric ) {
    // meter
    if ( __appSettings.lenUnit === 0 ){
        return ( parseFloat( length_metric ) ).toFixed( 1 )
    }
    // kilometer
    else if( __appSettings.lenUnit === 1 ){
        return ( parseFloat( length_metric ) * 0.001 ).toFixed( 1 )
    }
    // miles
    else if( __appSettings.lenUnit === 2 ){
        return ( parseFloat( length_metric ) * 0.0006213712 ).toFixed( 1 )
    }
    // n. miles
    else if( __appSettings.lenUnit === 3 ){
        return ( parseFloat( length_metric ) * 0.0005399568 ).toFixed( 1 )
    }
    // yard 1.09361
    else if( __appSettings.lenUnit === 4 ){
        return ( parseFloat( length_metric ) * 1.0936132983 ).toFixed( 1 )
    }
    // feet
    else if( __appSettings.lenUnit === 5 ){
        return ( parseFloat( length_metric ) * 3.280839895 ).toFixed( 1 )
    }
}
