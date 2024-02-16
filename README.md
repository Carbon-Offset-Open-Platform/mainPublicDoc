# mainPublicDoc
Main documentation of the SCOOP project

## Contribute

### Setting up
```
git clone git@github.com:Carbon-Offset-Open-Platform/mainPublicDoc.git
python3 -m venv venv
source venv/bin/activate
(venv) ~ pip install mkdocs-material
```

### Add content
1. Create a `.md` file in the respective folder and write your content in Markdown formatting. [Learn more here.](https://www.markdownguide.org/).
1. Edit `mkdocs.yml` and add your file to the `nav` section.
1. Commit and sync your GIT repo.

### Test and Build

After getting into the Python environment either run serve to see the results locally in your web browser:
```
source venv/bin/activate
(venv) ~ pip install mkdocs-material
mkdocs serve 
```

Or when everything is done, run build to create the static website:
```
mkdoc build
```

