echo "CHECKING IF input-tradeindia-category-links.txt EXISTS";
if [ ! -e "input-tradeindia-category-links.txt" ]; then
  echo "input-tradeindia-category-links.txt not found! Aborting...";
  exit;
fi

echo "CREATING BACKUP OF OLD DATA FILES";
if [ ! -d "backup" ]; then
  mkdir backup
fi
mv data-* backup/

echo "REMOVING OLD DATA FILES...";
rm data-*

echo "GETTING SUB CATEGORIES...";
ruby get_subcategories.rb;

echo "GETTING LINKS OF VENDORS FROM SUB CATEGORIES...";
ruby get_links.rb;

echo "GETTING EMAILS FROM LINKS...";
ruby get_emails.rb;

echo "-------------------------------------------------";
echo "Output File : data-tradeindia-emails.txt ";
echo "-------------------------------------------------";
echo "Completed Successfully.";





