
rsync --exclude-from 'rsync-exclude.txt' -av -e 'ssh' ./ agawulum@sl90.web.hostpoint.ch:/home/agawulum/www/staging.portamundi.org

rsync --exclude-from 'rsync-exclude.txt' -av -e 'ssh' ./ agawulum@sl90.web.hostpoint.ch:/home/agawulum/www/prod.portamundi.org

rsync -a agawulum@sl90.web.hostpoint.ch:/home/agawulum/www/prod.portamundi.org/web/uploads /Users/hendrik/Documents/Projects/porta-mundi/web/

rsync -a agawulum@sl90.web.hostpoint.ch:/home/agawulum/www/prod.portamundi.org/web/imager /Users/hendrik/Documents/Projects/porta-mundi/web/
