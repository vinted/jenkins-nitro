Jenkins test suite slowdown analyzer
=====================================

Analyze Jenkins test duration changes between builds and pinpoint the slowdowns

Usage
=====
View build time trend graph in Jenkins, pick two builds - one that was reasonably fast, another one after a slowdown. Feed them to `jenkins-nitro` and analyze the output:

![jenkins build time trend](https://dl.dropboxusercontent.com/u/176100/opensource/jenkins-nitro.png)

```
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
