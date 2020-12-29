.import QtQuick.LocalStorage 2.0 as Sql

var db;

// Create a table named settings, rows: name, value
function initDatabase() {
    try {
        db = Sql.LocalStorage.openDatabaseSync("mydb", "1.0", "Database for Surveying Calculator", 2000000);
        db.transaction( function(tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS settings(name TEXT, value TEXT)');
        });
    } catch (err) {
        console.log("Error opening database: " + err)
    }
}

// Settings for ComboBox
// Read current combo index
function readIndex(myvalue_str) {
    if(!db) { return; }
    var current_index = 0
    db.transaction( function(tx) {
        var result = tx.executeSql('select * from settings where name=?', [myvalue_str] );
        //console.log("result.rows[0].value", result.rows[0].value)
        if(result.rows.length === 1) {
            current_index = parseInt(result.rows[0].value)
        }
    });
    return current_index
}
// store the current index
function storeData_combo(myvalue, myvalue_str) {
    if(!db) { return; }
    db.transaction( function(tx) {
        var result = tx.executeSql('SELECT * from settings where name = ?', [myvalue_str]);
        if(result.rows.length === 1) {// use update
            result = tx.executeSql('UPDATE settings set value=? where name=?', [myvalue.currentIndex, myvalue_str]);
        } else { // use insert
            result = tx.executeSql('INSERT INTO settings VALUES (?, ?)', [myvalue_str, myvalue.currentIndex]);
        }
    });
}

// Settings for CheckBox or RadioButton
// returns checked or not (boolean)
function readChecked(myvalue_str) {
    if(!db) { return; }
    var checked_value = 0

    db.transaction( function(tx) {
        var result = tx.executeSql('select * from settings where name=?', [myvalue_str] );
        //console.log("result.rows[0].value", result.rows[0].value)
        if(result.rows.length === 1) {
            checked_value = parseInt(result.rows[0].value)
        }
    });
    //console.log("readChecked from the database for ", myvalue_str, ":", checked_value)
    return checked_value
}
// Store checked
function storeData_checked(myvalue, myvalue_str) {
    if(!db) { return; }
    db.transaction( function(tx) {
        var result = tx.executeSql('SELECT * from settings where name = ?', [myvalue_str]);
        if(result.rows.length === 1) {// use update
            //console.log("update db..", result.rows[0].value)
            result = tx.executeSql('UPDATE settings set value=? where name=?', [myvalue.checked, myvalue_str]);
        } else { // use insert
            result = tx.executeSql('INSERT INTO settings VALUES (?, ?)', [myvalue_str, myvalue.checked]);
        }
    });
}


// TextField
function storeData_txt(myvalue, myvalue_str) {
    if(!db) { return; }
    db.transaction( function(tx) {
        var result = tx.executeSql('SELECT * from settings where name = ?', [myvalue_str]);
        if(result.rows.length === 1) {// use update
            result = tx.executeSql('UPDATE settings set value=? where name=?', [myvalue.text, myvalue_str]);
        } else { // use insert
            result = tx.executeSql('INSERT INTO settings VALUES (?, ?)', [myvalue_str, myvalue.text]);
        }
    });
}

// example: readData_combo(mycombo, "mycombo")
/*function readData_combo(myvalue, myvalue_str) {
    if(!db) { return; }
    db.transaction( function(tx) {
        var result = tx.executeSql('select * from settings where name=?', [myvalue_str] );
        //console.log("result.rows[0].value", result.rows[0].value)
        if(result.rows.length === 1) {
            // get the value column
            myvalue.currentIndex = parseInt(result.rows[0].value);
            //console.log("result.rows[0].value", result.rows[0].value)
        }
    });
}*/
