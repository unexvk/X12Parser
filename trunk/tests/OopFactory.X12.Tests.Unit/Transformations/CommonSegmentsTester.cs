﻿using System;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using OopFactory.X12.Transformations;
using OopFactory.X12.Transformations.Common;
using System.IO;
using System.Reflection;
using System.Xml;
using System.Diagnostics;

namespace OopFactory.X12.Tests.Unit.Transformations
{
    [TestClass]
    public class CommonSegmentsTester
    {
        [TestMethod]
        public void ControlTransformTest()
        {
            var service = new ControlSegmentsTransformer(new X12EdiParsingService(false));

            string xml = service.Transform(new StreamReader(Extensions.GetEdi("INS._837P._5010.Example1_HealthInsurance.txt")).ReadToEnd());

            Trace.Write(xml);

            XmlDocument doc = new XmlDocument();
            doc.LoadXml(xml);
        }

        [TestMethod]
        public void EntitySegmentsTransformTest()
        {
            var service = new EntitySegmentsTransformer(new X12EdiParsingService(false));

            string xml = service.Transform(new StreamReader(Extensions.GetEdi("INS._837P._5010.Example1_HealthInsurance.txt")).ReadToEnd());

            Trace.Write(xml);

            XmlDocument doc = new XmlDocument();
            doc.LoadXml(xml);
        }
    }
}
