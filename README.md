# ronolinux - my custom debian builds

This project contains a set of small, simple custom
Debian builds. Those builds are pure Debian Software,
and this is not a custom derivative of Debian: just a
package selection that suits my needs and that I would
like to share with others.

## Download

You can download the files from SourceForge, on a mirror
closer to you:

	https://sourceforge.net/projects/ronolinux/files/snapshots/

Those files are pre-built images using the standard
Debian mirrors, and you can use them as normal for installing
more software after you use the instalation media. They
are also standard live media so you can run them from your
USB stick or ISO (CD/DVD). See this link for more details on the
![Live Manual][LiveManual]

## How to build your own

The script buildd will try to build the images locally,
configuring the package approx. You need to install the
dependencies in your machine:

	apt-get install live-build approx

And then, run the scripts under tools directory:

	tools/configure-local-apt-proxy
	tools/buildd

The buildd will run a clean build using `sudo`, so you may
need to run this script with a user that is in the group sudo.

## License

The project is distributed under the terms of the GNU
General Public License 2.0 or later.

[LiveManual]: http://live-systems.org/manual/stable/html/live-manual/the-basics.en.html#181
