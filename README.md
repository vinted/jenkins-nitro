Jenkins test suite slowdown analyzer
=====================================

Analyze Jenkins test duration changes between builds and pinpoint the slowdowns

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
Usage: jenkins-nitro <jenkins-job-url> <fast_build_number> <slow_build_number>
  Ex.: jenkins-nitro https://jenkins.example.com/job/foobar 120 158
```

View build time trend graph in Jenkins, pick two builds - one that was reasonably fast, another one after a slowdown. 

![jenkins build time trend](https://dl.dropboxusercontent.com/u/176100/opensource/jenkins-nitro.png)

Then feed slow and fast build numbers to `jenkins-nitro` and analyze the output:

```console
$ jenkins-nitro https://ci.jenkins-ci.org/job/jenkins_main_trunk 2882 2883
Slowdown	Test
============	====
   12.1620 s	org.jvnet.hudson.test.SleepBuilderTest
    0.0180 s	hudson.slaves.NodeListTest
    0.0070 s	hudson.MarkupTextTest
    0.0020 s	hudson.model.AbstractItemTest
    0.0010 s	hudson.logging.LogRecorderTest
    0.0010 s	hudson.BulkChangeTest
    0.0010 s	hudson.model.TimeSeriesTest
    0.0010 s	hudson.tasks._maven.Maven3MojoNoteTest
   -0.0010 s	jenkins.model.lazy.SortedListTest
   -0.0010 s	jenkins.model.lazy.SortedIntListTest
   -0.0130 s	hudson.model.ResourceListTest
   -0.2300 s	hudson.scheduler.CronTabEventualityTest
   -0.4880 s	hudson.cli.ConnectionTest
   -1.0250 s	hudson.FileSystemProvisionerTest
   -1.0820 s	hudson.scm.ChangeLogSetTest
   -1.1130 s	jenkins.ExtensionFilterTest
   -1.1560 s	hudson.security.PermissionGroupTest

Total slowdown from worst 50 changes
============
    7.0840 s
```

In the example above, `org.jvnet.hudson.test.SleepBuilderTest` got 12 seconds slower compared to previous build.


Contributing
============

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
