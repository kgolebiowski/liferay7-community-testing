# Liferay 7 Community Testing

This is my private repository for testing Liferay 7 within [Community Expedition Program] (https://dev.liferay.com/web/liferay-7-community-expedition). At the moment it contains a set of Vagrant configs that create Virtual Box machine provisioned in the following way:
* **Apache HTTPD** with *mod_proxy* redirecting all traffic to *ajp://localhost:8009*
* **PostgreSQL** with *lportal* scheme
* Current milestone release of **Liferay Portal 7** installed in */home/lportal/liferay*

I'm still working on this repository so I don't guarantee that everything works properly. If you know what you are doing, feel free to fork and contribute :)

## License

See the [LICENSE](LICENSE.md) file for license rights and limitations (GNU General Public License v2.0).
