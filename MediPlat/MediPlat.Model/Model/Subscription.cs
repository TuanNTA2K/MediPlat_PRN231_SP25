﻿using System;
using System.Collections.Generic;

namespace MediPlat.Model.Model;

public partial class Subscription
{
    public Guid Id { get; set; }

    public string? Name { get; set; }

    public decimal? Price { get; set; }

    public byte? EnableSlot { get; set; }

    public string? Description { get; set; }

    public DateTime? CreatedDate { get; set; }

    public DateTime? UpdateDate { get; set; }

    public virtual ICollection<DoctorSubscription> DoctorSubscriptions { get; set; } = new List<DoctorSubscription>();

    public virtual ICollection<Transaction> Transactions { get; set; } = new List<Transaction>();
}
