Jenkins Nitro: Test suite slowdown analyzer
===================================================

Command line tool for analyzing Jenkins test duration changes between fast and slow builds and pinpointing the cause of slowdown.

Installation
============

```console
$ gem install jenkins-nitro
```

Usage
=====

Run `jenkins-nitro` without arguments to get some help

```console
$ jenkins-nitro
Usage: jenkins-nitro <jenkins-job-url> <fast_build_number> <slow_build_number> [<entry_count=50>]
  Ex.: jenkins-nitro https://jenkins.example.com/job/foobar 120 158
  Ex.: jenkins-nitro https://jenkins.example.com/job/foobar 120 158 20
```

View build time trend graph in Jenkins, pick two builds - one that was reasonably fast, another one after a slowdown.

![jenkins build time trend](https://dl.dropboxusercontent.com/u/176100/opensource/jenkins-nitro.png)

Then feed slow and fast build numbers to `jenkins-nitro` and analyze the output:

```console
$ jenkins-nitro https://ci.jenkins-ci.org/job/jenkins_main_trunk 2882 2883
  Slowdown     Duration     ✖ slowdown, ✓ speedup, + new entry, - removed
============ ============ ==================================================
                12.1620 s   + org.jvnet.hudson.test.SleepBuilderTest
    0.0180 s     0.0320 s   ✖ hudson.slaves.NodeListTest
    0.0070 s     0.0080 s   ✖ hudson.MarkupTextTest
                 0.0020 s   + hudson.model.AbstractItemTest
                 0.0010 s   + hudson.logging.LogRecorderTest
                 0.0010 s   + hudson.BulkChangeTest
                 0.0010 s   + hudson.model.TimeSeriesTest
                 0.0010 s   + hudson.tasks._maven.Maven3MojoNoteTest
   -0.0010 s     0.0000 s   ✓ jenkins.model.lazy.SortedListTest
                            - jenkins.model.lazy.SortedIntListTest
                            - hudson.model.ResourceListTest
   -0.2300 s     0.0700 s   ✓ hudson.scheduler.CronTabEventualityTest
   -0.4880 s     0.6170 s   ✓ hudson.cli.ConnectionTest
   -1.0250 s     1.9380 s   ✓ hudson.FileSystemProvisionerTest
   -1.0820 s     1.7930 s   ✓ hudson.scm.ChangeLogSetTest
   -1.1130 s     1.9260 s   ✓ jenkins.ExtensionFilterTest
   -1.1560 s     1.7210 s   ✓ hudson.security.PermissionGroupTest

Total slowdown from top 17 changes
============
    7.0840 s
```

TODO
====

- Diff between two last builds if build numbers is not provided
- Ability to work with raw JUnit XML files instead of Jenkins URL
- Use optparse
- Add more options and flexibility

Contributing
============

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
