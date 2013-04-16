#!/bin/bash

ACTION=${1:-execute}
FILES_DIR=${2:-/opt/data}
MY_GIT_REPO=${3:-/opt/git-repo}
GIT_REMOTE=${4:-git@github.com:${USER}/files_repo.git}

syncfilesdir() {
  src_dir=${1}
  dst_dir=${2}
  
  pushd ${src_dir} &>/dev/null
    rsync -avzp --delete --exclude .git --exclude .gitignore . ${dst_dir}
  popd &>/dev/null
}

gitavail(){
  git_dir=${1}
  pushd  ${git_dir} &>/dev/null 
    test -d .git || git init .
  popd &>/dev/null
}

remoteavail(){
  [ "$#" -lt 2 ] && fail "did not pass git local and remote"
  git_dir=${1} 
  git_remote=${2}

  pushd  ${git_dir} &>/dev/null
    remotes=`git remote`
    [ "${remotes}" = "" ] && git remote add origin ${git_remote}
  popd &>/dev/null
}

gitcommit() {
  git_dir=${1} 
  pushd  ${git_dir} &>/dev/null
    commitmsg=`git status -s`
    if [[ "${commitmsg}" =~ "(working directory clean)" ]]; then
      echo "nothing to commit"; exit 0
    else
      commitmsg=`git status -s | tr "?" " "`
      git add -A
      git commit -a -m "$commitmsg";
    fi
  popd &>/dev/null
}

gitpush() {
  pushd  ${1} &>/dev/null
    git push origin master
  popd &>/dev/null
}

fail(){
  message=${1:-`echo "An unknown error has occored whilst executing $0"`}
  echo "$message - $0 will now exit"
  exit 2
}

usage(){
  printf "$0 {sync|execute} [ACTION FILES_DIR MY_GIT_REPO GIT_REMOTE]
          defaults to:
            $0 execute /opt/data/ /opt/git-repo git@github.com:${USER}/files_repo.git
  ";

}


if [ "$#" -lt 4 ]; then
  [ ! -z ${ACTION}      ] || fail 'ACTION not set'
  [ ! -z ${FILES_DIR}   ] || fail 'FILES_DIR parameter was not set'
  [ ! -z ${MY_GIT_REPO} ] || fail 'MY_GIT_REPO parameter was not set'
  [ ! -z ${GIT_REMOTE}  ] || fail 'GIT_REMOTE parameter was not set'
fi

case "$ACTION" in
  sync)
        # Just perform rsync ...
        syncfilesdir ${FILES_DIR} ${MY_GIT_REPO}
        ;;
  execute)
        syncfilesdir ${FILES_DIR} ${MY_GIT_REPO};
        gitavail ${MY_GIT_REPO};
        remoteavail ${MY_GIT_REPO} ${GIT_REMOTE}
        gitcommit ${MY_GIT_REPO} && gitpush ${MY_GIT_REPO};
        ;;
  *)
        usage
        exit 1
esac

