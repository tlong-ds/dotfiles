on adding folder items to this_folder after receiving these_items
	tell application "Finder"
		repeat with i from 1 to count of these_items
			set this_item to item i of these_items
			set fExt to (name extension of this_item) as lower case
			set folder_name to ""
			
			if fExt is "pdf" or fExt is "docx" or fExt is "doc" or fExt is "txt" or fExt is "md" or fExt is "tex" or fExt is "cls" then
				set folder_name to "Documents"
			else if fExt is "xlsx" or fExt is "csv" or fExt is "xls" or fExt is "xml" or fExt is "pbix" or fExt is "xlsm" then
				set folder_name to "Data & Spreadsheets"
			else if fExt is "png" or fExt is "jpg" or fExt is "jpeg" or fExt is "gif" or fExt is "webp" then
				set folder_name to "Images"
			else if fExt is "zip" or fExt is "dmg" or fExt is "pkg" or fExt is "exe" or fExt is "msc" then
				set folder_name to "Archives"
			else if fExt is "ipynb" or fExt is "py" or fExt is "js" or fExt is "sql" or fExt is "json" or fExt is "html" then
				set folder_name to "Programming"
			else if fExt is "mp3" or fExt is "m4a" or fExt is "wav" then
				set folder_name to "Audio"
			else if fExt is "cer" or fExt is "pem" or fExt is "key" then
				set folder_name to "Security"
			end if
			
			if folder_name is not "" then
				set target_path to ((this_folder as text) & folder_name)
				if not (exists folder target_path) then
					make new folder at this_folder with properties {name:folder_name}
				end if
				move this_item to folder target_path
			end if
		end repeat
	end tell
end adding folder items to
