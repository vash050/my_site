import dataset

db = dataset.connect('sqlite:///name_birds_from_kadastr.sqlite3')
table = db['birds']

with open('../../source/aves.txt', 'r') as f_ojb:
    list_name = []
    for line in f_ojb.readlines():
        line = line.strip()
        if line != '':
            list_name.append(line)
    # print(list_name)

tmp = None
aves_data = {'family_lat': '', 'family_rus': '', 'view_lat': '', 'view_rus': ''}

for idx, value in enumerate(list_name):
    try:
        int(value)
        aves_data['family_lat'] = list_name[idx + 1]
        aves_data['family_rus'] = list_name[idx + 2]
        aves_data['view_lat'] = list_name[idx + 3]
        aves_data['view_rus'] = list_name[idx + 4]
        table.insert(aves_data)
    except Exception:
        continue
