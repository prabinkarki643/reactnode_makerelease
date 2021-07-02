
# React-Node Release Build Maker

This code contains the core node js code to serve react build and sh file to make a final release build with both node and react combined.which will be used later in aws ec2 instance or any other terminal based web hosting


## Features

- Easy release build for react js to host on aws ec2 instance OR any other terminal
- Automatically store release build to github branch
- Single command to make build and release

  
## Usage/Examples
download zip of this file and put it into your react root directory as dot file eg: .reactnode_makerelease
#### now write a script inside package.json that will run the sh file present inside .reactnode_makerelease directory

```javascript
"scripts": {
    "make:release": "./.reactnode_makerelease/reactnode_makerelease.sh",
  }
```
#### make sure to give a proper permision to your .sh file before running above command.
  
## Tech Stack

**Client:** React

**Server:** Node, Express, Git, Bash, Shell Script
## Authors

- [@githubprabin143](https://github.com/githubprabin143/reactnode_makerelease)

  
## License

[MIT](https://choosealicense.com/licenses/mit/)

  