# Snippy.me: URL Shortener ![Java application](https://github.com/Dogacel/Kalas-Iris/workflows/Python%20application/badge.svg) ![Node.js CI](https://github.com/Dogacel/Kalas-Iris/workflows/Node.js%20CI/badge.svg)
<!--
***yukardaki svgleri değiş
-->

https://www.snippy.me

Feel free to edit this document.

## About

Snippy.me is a CS443 Cloud Computing project for shortening URLs.

[Design Report](design report here)


### TODO:

- [x] Initialize Spring Boot microservices
- [x] Second
- [x] Third
- [ ] ..
- [ ] ..
- [ ] Add more tasks

## Project Structure

- `app/`
- `web/` 
- 

## Project Setup

...

### Requirements

...

### Java SDK (... prefered)

```bash
$ blablabla
```

### ...

[More info]()

```bash
```

### Setup

You only have to setup once unless there are new features added.

```bash
$ ..
```

_Note_: There are no database connections right now. The setup instructions are open to change.

### Running

#### API

```bash
$ cd api
$ sh run.sh # Or ./run.sh
```

#### Website

```bash
$ cd web
$ npm start # This might take a while on the first run. It will install dependencies
```

#### Redis
After gaining permission to the database, create a .env file containing your username and password. It should have the following format. 
```bash
$ DATABASE_USERNAME = "yourusername"
$ DATABASE_PASSWORD = "yourpassword"
```
For more on .env files, you can visit [here](https://pypi.org/project/python-dotenv/) and [here](https://www.ibm.com/support/knowledgecenter/ssw_aix_72/osmanagement/env_file.html)

### About Git and Github

If you are having troubles using git on command line, I highly suggest you to use [GitKraken](https://www.gitkraken.com/). You can also see their [tutorials](https://www.gitkraken.com/learn/git) they are short. But still I will try to explain some about the workflow.

- Use issues and pull requests.

- Everyone uses their own branches ideally. Those branches get merged after they are completed. For example if you want to add an about page, create a branch ata/about-page. Work on that branch. If someone needs to work with you, they will also work on that branch. This might not be the case in the beginning of the project, it is OK to use until codebase gets complex. But still, please don't upload broken commits.

- **Never force push.**

- Stash your local changes before you pull.

- Pull the master or the branch you are working on everytime you start doing something. **NEVER** pull while you have local changes and merge. Unnecessary merge commits will make git repository very complex and hard to deal with. Also you might mess up the code.

- When a merge is necessary, please don't just overwrite the incoming changes. Take your time and work on it.

### Useful Links

- [AntDesign](https://ant.design/)
