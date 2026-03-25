# phpmyadmin-railway

Custom phpMyAdmin wrapper for Railway.

This image wraps the official `phpmyadmin:5` image and fixes Apache MPM conflicts that can happen on Railway deployments. It disables conflicting Apache MPM modules, enables `mpm_prefork`, sets a simple `ServerName`, and then hands control back to the original phpMyAdmin entrypoint.

## Why this exists

On some Railway deployments, the official phpMyAdmin image can fail with:

    AH00534: apache2: Configuration error: More than one MPM loaded.

This wrapper fixes that during container startup without replacing the original phpMyAdmin boot logic.

## Files

- `Dockerfile` — builds the wrapper image on top of the official phpMyAdmin image
- `docker-entrypoint.sh` — disables conflicting Apache MPM modules and starts the original entrypoint

## Railway variables

Use only:

    PMA_HOST=${{MariaDB.RAILWAY_PRIVATE_DOMAIN}}
    PMA_PORT=3306

Optional when exposing phpMyAdmin behind a public proxy or public domain:

    PMA_ABSOLUTE_URI=https://your-public-phpmyadmin-url/

## Notes

- Do not use a Railway custom start command with this image.
- Do not mount custom phpMyAdmin config files unless you really need them.
- Log into phpMyAdmin with your MariaDB username and password, not your gateway credentials.

## Image base

This wrapper uses:

    phpmyadmin:5
