
AddEventHandler("NamelessCore:NewEmployee", function(src, newCharacter)
	newCharacter = MySQL.insert('INSERT INTO characters (identifier, firstname, lastname, dob, gender, department, csn) VALUES (?, ?, ?, ?, ?, ?, ?)', {
		src.identifier,src, fullname, src.firstname, src.name,src.lastname, src.dob, src.gender
	})
end)