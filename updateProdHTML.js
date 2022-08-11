var spawn = require('child_process'),
    git = spawn('git', ['log', '--pretty=format:\'%H\'', '-n', '1']);

git.stdout.on('data', tag => {
    var fs = require('fs'),
        template = fs.readFileSync('prod_template.html', 'utf-8').replace(/269ae355f21dbc53d17fd672160181d760f58911/g, tag);

    fs.writeFileSync('../production.html', prodTemplate);
    fs.writeFileSync('../s3_production.html', s3Template);
    fs.writeFileSync('../local_production.html', localTemplate);
    fs.writeFileSync('../branchManagement_production.html', localTemplate);
});
